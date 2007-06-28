From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH] git-submodule: Try harder to describe the status of a submodule
Date: Thu, 28 Jun 2007 06:01:29 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27011CFFED@az33exm24.fsl.freescale.net>
References: <118297160163-git-send-email-Emilian.Medve@Freescale.com> <7v1wfwpuy2.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 15:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3tcu-0001Lj-2Y
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 15:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761125AbXF1NBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 09:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761099AbXF1NBe
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 09:01:34 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:54844 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760836AbXF1NBd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 09:01:33 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id l5SD1UKv017180
	for <git@vger.kernel.org>; Thu, 28 Jun 2007 06:01:31 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5SD1Uw8004232
	for <git@vger.kernel.org>; Thu, 28 Jun 2007 08:01:30 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7v1wfwpuy2.fsf@assigned-by-dhcp.pobox.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] git-submodule: Try harder to describe the status of a submodule
Thread-Index: Ace5PEmGzO9ex5ncSkKbabNzVZB7zgAR/sUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51103>

Hello Junio,


Alright, let's go with your patch.


Cheers,
Emil.


This e-mail, and any associated attachments have been classified as:
--------------------------------------------------------------------
[x] Public
[ ] Freescale Semiconductor Internal Use Only
[ ] Freescale Semiconductor Confidential Proprietary


-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Wednesday, June 27, 2007 11:25 PM
To: Medve Emilian-EMMEDVE1
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-submodule: Try harder to describe the status of
a submodule

Emil Medve <Emilian.Medve@Freescale.com> writes:

> Some repositories might not use/have annotated tags (for example
repositories created with
> git-cvsimport) or might not have tags at all and could cause
git-submodule status to fail because
> git-describe might fail.
>
> This change makes git-submodule status try harder in displaying the
status of a module by
> considering lightweight tags, subsequent tags and branches.

Why are we suddenly seeing these loooooooong lines...

> +get_revname()
> +{
> +	_revname=$(git-describe --tags "$1" 2>/dev/null || git-describe
--contains "$1" 2>/dev/null)
> +	if test -z "$_revname" -o "$_revname" = "undefined"
> +	then
> +		_revname=$(git-describe --all "$1" 2>/dev/null | cut -d
/ -f2-)
> +		test -z "$_revname" && _revname=undefined
> +	fi

I really do not think using --all is useful.  If you do not have
a tag and the rev cannot be described, what damage does it incur?

We still say "$sha1 $path" in the output anyway, and ($revname)
is only "it makes it nicer" appendix.

> @@ -155,7 +174,7 @@ modules_list()
>  			say "-$sha1 $path"
>  			continue;
>  		fi
> -		revname=$(unset GIT_DIR && cd "$path" && git-describe
$sha1)
> +		revname=$(unset GIT_DIR && cd "$path" && get_revname
$sha1)
>  		if git diff-files --quiet -- "$path"
>  		then
>  			say " $sha1 $path ($revname)"

In that sense, I would prefer mine much better. If a rev is
indescribable, your version would say:

	" dddddddddddddddddddddddddddddddddddddddd subdir (undefined)"

while mine would have said:

	" dddddddddddddddddddddddddddddddddddddddd subdir"
