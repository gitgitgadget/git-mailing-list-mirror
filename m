From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Fri, 3 Jun 2016 10:53:27 -0400
Message-ID: <575199E7.7000503@xiplink.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 16:53:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8qTh-00089z-OV
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 16:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbcFCOxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 10:53:31 -0400
Received: from smtp82.ord1c.emailsrvr.com ([108.166.43.82]:37537 "EHLO
	smtp82.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128AbcFCOxb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 10:53:31 -0400
Received: from smtp3.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp3.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 4F42B180246;
	Fri,  3 Jun 2016 10:53:29 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp3.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5A530180175;
	Fri,  3 Jun 2016 10:53:28 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Fri, 03 Jun 2016 10:53:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160603110843.15434-4-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296332>

On 2016-06-03 07:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> When there are lots of ref updates, each has different name length, t=
his
> will make it easier to look because the variable part is at the end.

s/look/read/

=46or the record, I prefer the earlier stair-step format to this
	{xxx -> yyy}/foo
stuff.

Peff suggested that a two-pass approach might not be too bad, but had=20
problems when he tried it with extra-long refs.  Maybe those problems=20
could be dealt with, and we could get a simple, aligned output?

What if we detect when the full line exceeds the terminal width, and=20
insert a newline after the remote ref and indent the ->  to the same=20
offset as its surrounding lines, like this:

  * [new branch]      2nd-index -> pclouds/2nd-index
  * [new branch]      some-kind-of-long-ref-name
                                -> pclouds/some-kind-of-long-ref-name
  * [new branch]      3nd-index -> pclouds/3nd-index

> ---
>   Documentation/git-fetch.txt |  7 +++++++
>   builtin/fetch.c             | 37 ++++++++++++++++++++++++++++++++++=
++-
>   t/t5510-fetch.sh            |  4 ++--
>   t/t5526-fetch-submodules.sh | 26 +++++++++++++-------------
>   4 files changed, 58 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.tx=
t
> index 18e733c..61c3bd1 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -113,6 +113,13 @@ representing the status of a single ref. Each li=
ne is of the form:
>    <flag> <summary> <from> -> <to> (<reason>)
>   -------------------------------
>
> +When `from` and `to` share a common suffix, the line could be
> +displayed in the form:
> +
> +-------------------------------
> + <flag> <summary> {<from> -> <to>}<suffix> (<reason>)

If we go with this format, we'll need to document <suffix>.  I'm not=20
sure how to describe it succinctly, especially since it's not always=20
used.  Really there are two possible output formats:

	<flag> <summary> {<from> -> <to>}<suffix> (<reason>)
	<flag> <summary> <from> -> <to> (<reason>)

This is starting to feel too complex.

		M.
