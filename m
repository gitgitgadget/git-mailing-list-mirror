From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/4] grep: add more information to hunk separators
Date: Mon, 26 Mar 2012 18:16:36 +0200
Message-ID: <4F709664.1060206@lsrfire.ath.cx>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 18:16:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCCbC-00081a-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 18:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924Ab2CZQQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 12:16:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:33443 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866Ab2CZQQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 12:16:42 -0400
Received: from [192.168.2.105] (p4FFD9672.dip.t-dialin.net [79.253.150.114])
	by india601.server4you.de (Postfix) with ESMTPSA id 9CD242F8038;
	Mon, 26 Mar 2012 18:16:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193922>

Am 26.03.2012 04:41, schrieb Mark Lodato:
> This patch series adds a new `grep --hunk-heading' option that moves =
the
> filename and line number to the hunk separator lines ("--") rather th=
an at the
> beginning of each matching (or context) line.  In my opinion, this ma=
kes the
> output easier to read, especially when combined with `--heading'.
>
> I am not sure that "hunk-heading" is the best term, so I welcome idea=
s on
> better names.
>
> Here's an example:
>
>      # Current behavior:
>      $ git grep -p -C1 -n list_common -- git.c
>      git.c=3D531=3Dint main(int argc, const char **argv)
>      --
>      git.c-570-              printf("usage: %s\n\n", git_usage_string=
);
>      git.c:571:              list_common_cmds_help();
>      git.c-572-              printf("\n%s\n", git_more_info_string);
>
>      # New option:
>      $ git grep -p -C1 --hunk-heading list_common -- git.c
>      -- git.c:531 --
>      int main(int argc, char argv)
>      -- git.c:570 --
>                      printf("usage: %s\n\n", git_usage_string);
>                      list_common_cmds_help();
>                      printf("\n%s\n", git_more_info_string);
>
>      # New option with --heading:
>      $ git grep -p -C1 --hunk-heading --heading list_common -- git.c
>      git.c
>      -- 531 --
>      int main(int argc, char argv)
>      -- 570 --
>                      printf("usage: %s\n\n", git_usage_string);
>                      list_common_cmds_help();
>                      printf("\n%s\n", git_more_info_string);
>
> Originally, I had envisioned also moving the function name (`-p') to =
the hunk
> header, similar to the diff context line.  For example:
>
>      -- git.c:570 -- int main(int argc, char argv)
>                      printf("usage: %s\n\n", git_usage_string);
>                      list_common_cmds_help();
>                      printf("\n%s\n", git_more_info_string);
>
> After implementing this feature, I was not happy with the result and
> subsequently removed it.  To me, the output was too cluttered and the=
 line
> number was ambigous.  For example, in the above, it is not obvious to=
 me that
> line 570 is the "printf" line and not the "int main" line.  Still, if=
 you
> would like to see the patch to implement this feature, please let me =
know.

Interesting.

By the way, I keep this alias in my config (a single line), to mimic ac=
k=20
(http://betterthangrep.com/) -- another way to format results, with=20
similar goals:

	ack =3D -c color.grep.filename=3D'bold green' \
	-c color.grep.match=3D'black yellow' grep --break --heading -n

Back to your patch: Why the second set of "--" after the line number?  =
I=20
can see it make sense if a section comment follows, but not without one=
=2E

Looking at the above, I thought: We have unified diffs between two=20
files, we have combined diffs between more than two, what about showing=
=20
grep results as one-sided unified diffs?  ("What's the sound of one han=
d=20
clapping?" :-)

	--- a/git.c
	@ -570,3 @ int main(int argc, const char **argv)
	-		printf("usage: %s\n\n", git_usage_string);
	:		list_common_cmds_help();
	-		printf("\n%s\n", git_more_info_string);

Pro: Generalization of an established format for showing interesting=20
parts of a file.  Less duplication of meta-information.  Markers that=20
tell us the kind of the shown lines are kept ("-" for context, ":" for=20
matches).  Machine parsable.

Con: Why the "a/" prefix?  One-sided diffs, srsly?

Ren=E9
