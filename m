X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Adding glob support to remotes
Date: Wed, 22 Nov 2006 12:50:13 -0800
Message-ID: <7v3b8bryt6.fsf@assigned-by-dhcp.cox.net>
References: <200611220904.21850.andyparkins@gmail.com>
	<7v7ixnskql.fsf@assigned-by-dhcp.cox.net>
	<200611221441.02459.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 20:50:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611221441.02459.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 22 Nov 2006 14:41:00 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32101>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmz2z-0006pv-Uu for gcvg-git@gmane.org; Wed, 22 Nov
 2006 21:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755328AbWKVUuS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 15:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbWKVUuS
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 15:50:18 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22932 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1755328AbWKVUuQ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 15:50:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122205015.HBAP5575.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Wed, 22
 Nov 2006 15:50:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id pwpk1V00Z1kojtg0000000; Wed, 22 Nov 2006
 15:49:46 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2006 November 22 12:56, Junio C Hamano wrote:
>
>> > However, git-ls-remote needs the name of the remote repository (of
>> > course), but that isn't directly available in git-parse-remote.sh.
>>
>> Is it really the case?  I do not remember the details offhand,
>> but I do not think canon_refs_list_for_fetch is the function you
>> should be messing with to implement the remote."origin".fetch
>> stuff.  It should be get_remote_default_refs_for_fetch().  The
>> function returns the list based on which remote, so it surely
>> knows which remote the caller is talking about.
>
> The problem is that canon_refs_list_for_fetch bombs out too early because "*" 
> is not an acceptable name for a ref.

I do not understand and that is why I do not understand why you
would need to touch check-ref-format.

"remote.$1.fetch" is read by get_remote_default_refs_for_fetch
and currently the value is given canon_refs_list_for_fetch
without any preprocessing.  My suggestion is to catch the
"wildcard" in get_remote_default_refs_for_fetch, do your
replacement based on an earlier ls-remote output, and give
replaced values to canon_refs_list_for_fetch.  That way I do not
think check-ref-format that is used by canon_refs_list_for_fetch
needs to see any wildcard.

Both config and remotes but not branches _could_ have wildcard
so you would need to do the same wildcard replacement in two
case arms of get_remote_default_refs_for_fetch but I think that
can be done in a common helper function.

If on the other hand if you want to do this in canon_*, then you
could do that before the "for ref" loop to set "$@" to the
wildcard-expanded form.  But there are other codepaths that use
this function and I do not know if you want to apply the
wildcarding to all of them (I haven't checked all the callers).
If you are sure all the callers want the wildcarding the same
way, it would be more appropriate to do so there than doing it
in get_remote_default_refs_for_fetch as I suggested in the
above.  I.e. something like this perhaps.

 canon_refs_list_for_fetch () {
 ...
 			    --get-all "branch.${curr_branch}.merge")
 		fi
 	fi
+
+	expanded_ref_list=
+	for ref
+	do
+		if ref is wildcard
+		then
+			compute wildcard replacement and set it to nref
+			expanded_ref_list="$expanded_ref_list $nref"
+		else
+			expanded_ref_list="$expanded_ref_list $ref"
+		fi
+	done
+	set x $expanded_ref_list
+	shift
+
 	for ref
 	do
 		force=


>>  (1) dumb protocols currently cannot deal with a remote that has
>
> I'm not sure I've understood this point.  I shall look at git-fetch.sh more 
> closely to try and address this though.

I was talking about this part of the code:

      case "$remote" in
      http://* | https://* | ftp://*)
	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
	      curl_extra_args="-k"
	  fi
	  if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
		"`git-repo-config --bool http.noEPSV`" = true ]; then
	      noepsv_opt="--disable-epsv"
	  fi
	  max_depth=5
	  depth=0
	  head="ref: $remote_name"
	  while (expr "z$head" : "zref:" && expr $depth \< $max_depth) >/dev/null
	  do
	    remote_name_quoted=$(@@PERL@@ -e '
	      my $u = $ARGV[0];
              $u =~ s/^ref:\s*//;
	      $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
	      print "$u";
	  ' "$head")
	    head=$(curl -nsfL $curl_extra_args $noepsv_opt "$remote/$remote_name_quoted")
	    depth=$( expr \( $depth + 1 \) )
	  done
	  expr "z$head" : "z$_x40\$" >/dev/null ||
	      die "Failed to fetch $remote_name from $remote"
	  echo >&2 Fetching "$remote_name from $remote" using http
	  git-http-fetch -v -a "$head" "$remote/" || exit
	  ;;

The while loop is initialized with "ref: refs/heads/$branch", 
extracts the "refs/heads/$branch" from it by hand, and runs
"curl -nsfL" to get http://host/repo.git/refs/heads/$branch,
until it is not a symref anymore (refs/heads/$branch _could_
be a symref that points at refs/heads/$another, and that is the
loop is about).  At the end of the loop, $head would contain
what is read from the ref -- 40-byte object name.  That is given
to git-http-fetch.

However, the above assumes $GIT_DIR/refs/heads/$branch file
exists at the remote end for "curl -nsfL" to fetch.  When refs
are packed-and-pruned, refs/heads/$branch may not exist as a
standalone file; the right way to learn "what object does a ref
point at" is to ask ls-remote, and if you do one ls-remote
upfront then all you need to do here is a single grep.

