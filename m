From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 5 May 2008 00:13:20 +0200
Message-ID: <20080504221319.GA14584@alea.gnuu.de>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <slrng1bqhb.25r.joerg@alea.gnuu.de> <04EB077D-CB35-4253-A9EA-2085890C3639@silverinsanity.com> <20080430090206.GA21826@alea.gnuu.de> <5374CF8E-3E6E-480B-A23B-13BE85C7ABCF@silverinsanity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon May 05 00:15:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsmUU-00066z-Td
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 00:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbYEDWOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 18:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbYEDWOi
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 18:14:38 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2034 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245AbYEDWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 18:14:37 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id DD993488033; Mon,  5 May 2008 00:14:34 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JsmSX-0008GO-C4; Mon, 05 May 2008 00:13:33 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JsmSO-0007MB-Hb; Mon, 05 May 2008 00:13:20 +0200
Content-Disposition: inline
In-Reply-To: <5374CF8E-3E6E-480B-A23B-13BE85C7ABCF@silverinsanity.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81207>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Brian,

Brian Gernhardt schrieb am Wed 30. Apr, 11:25 (-0400):
> On Apr 30, 2008, at 5:02 AM, J=C3=B6rg Sommer wrote:
>
>>> I also dislike the large lists this is carrying around in shell
>>> variables.  If I'm reading it correctly, the tag list could be =20
>>> replaced
>>> by invocations of "git describe --exact-match".
>>
>> Yes. How to get all tags of a commit?
>>
>> % git tag foo v1.5.5
>> % git describe --exact-match 9d831805195ba40b62f632acc6bb6e53d3
>> warning: tag 'v1.5.5' is really 'foo' here
>> v1.5.5

And how can I get only tags no annotated tags? We can't recreate
annotated tags with git rebase.

> Those concerns being: overrunning the length of a shell variable,

Are you shure there is any such bounding? I didn't saw anything about the
size of a variables in IEEE=C2=A01003.1-2004, but didn't look very carfully.
All my shells (bash, dash, zsh) can handle more than 16777217 characters:

dash -c 'a=3Da; while :; do a=3D$a$a; echo $a | wc -c; done'

This would be a new version of create_extended_todo_list() without tac.
What do you think about it? Is it better readable? But there's a bug.

create_extended_todo_list () {
	# The idea of this function is to
	# 1. build a list of tags
	# 2. go through the list and
	#    * issue a reset command to the parent of the commit, if the last
	#      commit was not the parent of the current commit,
	#    * issue a pick command for simple commits,
	#    * issue for each merge commit a merge command with the hashs of
	#      the parent commits,
	#    * register each parent of a merge and issue a mark command
	#      (without an ID) after the commit for each registered commit and
	#    * issue a tag command, if the commit is in the tag list.
	# 3. Then go through the created list and
	#    * add an ID to each mark command and
	#    * replace all occurences of the hash in reset and merge commands
	#      by the mark ID
	test -e "$DOTEST"/cetl.tmp \
		&& die "Someone else uses our filename cetl.tmp." \
			"That's not nice"
	if test t =3D "${PRESERVE_TAGS:-}"
	then
		tag_list=3D$(git show-ref --abbrev=3D7 --tags | \
			(
			while read sha1 tag
			do
				tag=3D${tag#refs/tags/}
				if test ${last_sha1:-0000} =3D $sha1
				then
					saved_tags=3D"$saved_tags:$tag"
				else
					printf "%s" "${last_sha1:+ $last_sha1#$saved_tags}"
					last_sha1=3D$sha1
					saved_tags=3D$tag
				fi
			done
			echo "${last_sha1:+ $last_sha1:$saved_tags}"
			) )
	else
		tag_list=3D
	fi
	mark_these_commits=3D
	while IFS=3D_ read commit parents subject
	do
		first_parent=3D${parents%% *}
		if test "${last_commit:-$SHORTUPSTREAM}" !=3D $first_parent
		then
			test "$first_parent" =3D $SHORTUPSTREAM &&
				first_parent=3D$SHORTONTO
			echo reset $first_parent
		fi
		unset first_parent
		last_commit=3D$commit

		case "$parents" in
		*' '*)
			new_parents=3D
			for p in $parents
			do
				mark_these_commits=3D$(insert_value_at_key_into_list \
					"$commit" "$p" "$mark_these_commits")
				if test "$p" =3D $SHORTUPSTREAM
				then
					new_parents=3D"$new_parents $SHORTONTO"
				else
					new_parents=3D"$new_parents $p"
				fi
			done
			unset p
			echo merge $commit ${new_parents# * }
			unset new_parents
			;;
		*)
			echo "pick $commit $subject"
			;;
		esac

		if tmp=3D$(get_value_from_list $commit "$tag_list")
		then
			for t in $(echo $tmp | tr : ' ')
			do
				echo tag $t
			done
		fi
	done > "$DOTEST"/cetl.tmp
	unset commit parents subject

	commit_mark_list=3D
	next_mark=3D0
	last_commit=3D
	while read cmd args
	do
		case "$cmd" in
		pick)
			this_commit=3D"${args%% *}"
			;;
		reset)
			this_commit=3D$args
			if tmp=3D$(get_value_from_list $args "$commit_mark_list")
			then
				args=3D":$tmp"
			fi
			;;
		merge)
			new_args=3D
			for i in ${args#* }
			do
				if tmp=3D$(get_value_from_list $i \
					"$commit_mark_list")
				then
					new_args=3D"$new_args :$tmp"
				else
					new_args=3D"$new_args $i"
				fi
			done
			this_commit=3D"${args%% *}"
			args=3D"$this_commit ${new_args# }"
			;;
		esac

		if tmp=3D$(get_value_from_list "$last_commit" \
			"$mark_these_commits") && \
			test "${this_commit:-$last_commit}" !=3D $tmp
		then
			if tmp=3D$(get_value_from_list "$last_commit" \
				"$commit_mark_list")
			then
				test "$last_cmd" =3D reset -o "$last_cmd" =3D tag \
					|| echo mark ":$tmp"
			else
				commit_mark_list=3D$(insert_value_at_key_into_list \
					$next_mark $last_commit "$commit_mark_list")
				echo mark ":$next_mark"
				next_mark=3D$(($next_mark + 1))
			fi
		fi
		last_commit=3D${this_commit:-$last_commit}
		unset this_commit

		echo "$cmd $args"
		last_cmd=3D$cmd
	done < "$DOTEST"/cetl.tmp
	rm "$DOTEST"/cetl.tmp
	unset last_cmd last_commit next_mark cmd args tmp commit_mark_list \
		mark_these_commits
}

The problem is the mark command. If you walk from ONTO to HEAD trough the
list, you must know for a commit, if it is used _later_. But don't create
a mark if it is used immediately, e.g. pick; merge not pick; mark; merge.

If you walk from HEAD to ONTO, this is much easier. I delayed the mark
for the first head of a merge and checked if the next commit is this
commit. This way I keep the todo list clean and don't get something like
this for --first-parent:

pick abc
pick def
mark :0
merge 012 foreign-branch

Bye, J=C3=B6rg.
--=20
Es ist au=C3=9Ferdem ein weit verbreiteter Irrtum das USENET =E2=80=9Ahelfe=
n=E2=80=98 soll.
Tats=C3=A4chlich wurde USENET nachweislich zur pers=C3=B6nlichen Belustigung
seiner Erfinder geschaffen.
J=C3=B6rg Klemenz <joerg@gmx.net>, <b4ai4o$1u8vmt$2@ID-21915.news.dfncis.de>

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIHjT/we0mZwH1VIARAlrbAJ4wnakncuo8kh93zIVYlRq6KE43igCfVOFY
EDmjF6AjqQioF+5CeFDkpII=
=yXer
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
