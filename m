From: Jeff King <peff@peff.net>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Mon, 11 Apr 2016 13:27:41 -0400
Message-ID: <20160411172741.GD4011@sigill.intra.peff.net>
References: <570965B9.9040207@jupiterrise.com>
 <20160409210429.GB18989@sigill.intra.peff.net>
 <57098259.1060608@jupiterrise.com>
 <20160409223738.GA1738@sigill.intra.peff.net>
 <xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
 <xmqq37qtthit.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 19:28:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apfd4-0001dx-GL
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 19:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbcDKR1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 13:27:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:47559 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754728AbcDKR1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 13:27:45 -0400
Received: (qmail 9014 invoked by uid 102); 11 Apr 2016 17:27:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 13:27:43 -0400
Received: (qmail 27653 invoked by uid 107); 11 Apr 2016 17:27:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 13:27:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Apr 2016 13:27:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqq37qtthit.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291224>

On Sun, Apr 10, 2016 at 12:01:30PM -0700, Junio C Hamano wrote:

> > diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
> > index 8e22b03..6dedb1c 100755
> > --- a/t/t1020-subdirectory.sh
> > +++ b/t/t1020-subdirectory.sh
> > @@ -142,9 +142,9 @@ test_expect_success 'GIT_PREFIX for built-ins' '
> >  	# Use GIT_EXTERNAL_DIFF to test that the "diff" built-in
> >  	# receives the GIT_PREFIX variable.
> >  	printf "dir/" >expect &&
> > -	printf "#!/bin/sh\n" >diff &&
> > -	printf "printf \"\$GIT_PREFIX\"" >>diff &&
> > -	chmod +x diff &&
> > +	write_script diff <<-\EOF &&
> > +	printf "%s" "$GIT_PREFIX"
> > +	EOF
> >  	(
> >  		cd dir &&
> >  		printf "change" >two &&
> 
> Regarding this one, I notice that "expect" and "actual" (produced
> later in this script by executing "diff" script) are eventually
> compared by test_cmp, which runs "diff" to show the actual
> differences.  If we are doing this modernization to use write_script
> more, we probably should make "expect" and "actual" text files that
> end with a complete line.

Yeah I wondered about that. And also the fact that the shell script
itself doesn't end in newline. But I think that is just an accident, and
no shell happened to complain (not that I would expect them to, but we
come across enough weirdness around final newlines with tools like sed
and tr, I wouldn't have been surprised).

> -- >8 --
> Subject: t1020: do not overuse printf and use write_script
> 
> The test prepares a sample file "dir/two" with a single incomplete
> line in it with "printf", and also prepares a small helper script
> "diff" to create a file with a single incomplete line in it, again
> with "printf".  The output from the latter is compared with an
> expected output, again prepared with "printf" hance lacking the
> final LF.  There is no reason for this test to be using files with
> an incomplete line at the end, and these look more like a mistake
> of not using
> 
> 	printf "%s\n" "string to be written"
> 
> and using
> 
> 	printf "string to be written"
> 
> Depending on what would be in $GIT_PREFIX, using the latter form
> could be a bug waiting to happen.  Correct them.
> 
> Also, the test uses hardcoded #!/bin/sh to create a small helper
> script.  For a small task like what the generated script does, it
> does not matter too much in that what appears as /bin/sh would not
> be _so_ broken, but while we are at it, use write_script instead,
> which happens to make the result easier to read by reducing need
> of one level of quoting.

Looks good to me. I suspect you could actually just use:

  echo "$GIT_PREFIX"

in the helper script. That is also not completely safe against arbitrary
bytes in $GIT_PREFIX (due to unportable backslash escapes), though I
suspect it would be fine for the purposes of the test script. Using a
proper printf isn't that many more bytes, though.

-Peff
