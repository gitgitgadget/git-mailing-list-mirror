From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] diff -c -p: do not die on submodules
Date: Wed, 29 Apr 2009 23:50:20 +0200
Message-ID: <81b0412b0904291450w3d292ed5i3b2ab5164c0ae0f4@mail.gmail.com>
References: <gt7err$3m4$1@ger.gmane.org>
	 <7v4ow8my1u.fsf@gitster.siamese.dyndns.org>
	 <20090428211257.GA31191@pvv.org> <20090429084209.GA24064@localhost>
	 <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org>
	 <7vy6tj8aur.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHgR-0001m8-OA
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbZD2VuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 17:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbZD2VuX
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:50:23 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:58908 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZD2VuW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 17:50:22 -0400
Received: by bwz7 with SMTP id 7so1453792bwz.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IuAqIVH7Gd6xntgxYucJKkvxRXREBbz/tNDuSnyxqDY=;
        b=R5ofBaC2J3HOuH5oKFVydi0tmP7o0mvDXf0638E+v1ArwHhtp9MQy347pWVXlisa1x
         ISUilrkF0FJvHDeVEr1crMZkZ8FkpRpE1U0TDO6xmpn8WnNC18iBUkwEpkcujanAU3wi
         +7PmPHGo88w+iugb3Z3l4oL8K88xB1SrW+t+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UwJk3C30quZh4aUPOtLfx1vlGlLJolQLRtS8hpMwa5AULQtqM6uAV6OYd6Z79H1xtD
         BVN+ADl/TWHFhsZph0lg/ytOr4PGfuzWzzRvIREgN+gVftW+SrhG/Wq8p6wIOx+GHMJS
         6lRn4qhIRxlIFaF7CKOSFVSpHljEeq6SmE9Jw=
Received: by 10.204.118.66 with SMTP id u2mr733610bkq.132.1241041820757; Wed, 
	29 Apr 2009 14:50:20 -0700 (PDT)
In-Reply-To: <7vy6tj8aur.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117956>

2009/4/29 Junio C Hamano <gitster@pobox.com>:
> +
> + =C2=A0 =C2=A0 =C2=A0 if (S_ISGITLINK(mode)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob =3D xmalloc(1=
00);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D snprintf=
(blob, 100,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Subproject commit %s\n", sha=
1_to_hex(sha1));

snprintf returns a signed value. It also has a bad record of returning
negative values for obscure reasons (on obscure platforms, admittedly).

=46or this particular case,

  strcpy(blob, "Subproject commit ");
  strcat(blob, sha1_to_hex(sha1));
  strcat(blob, "\n");
  *size =3D strlen(blob); /* that's a constant */

could be considered.
