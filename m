From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] Retry HTTP requests on SSL connect failures
Date: Mon, 1 Oct 2012 20:14:35 -0400
Message-ID: <CAM9Z-nkSio-fXPAw_qaZsPhT-DHjn+AOOfZMXQYFCmeQAs+cJA@mail.gmail.com>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
	<1349126586-755-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 03:05:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIqvg-0008FN-3O
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 03:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab2JBAOk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2012 20:14:40 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54679 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab2JBAOg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 20:14:36 -0400
Received: by ieak13 with SMTP id k13so13550070iea.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zjueqrnTu/t1BWekvXJUd7+kFulW/Bx8Y+B90wofwi4=;
        b=J2zeOg3FPN+nzcfqHX5moHdsM9oS2LGinBJd3AYsJJEhpqhZJr3sgBYPptE7YkKDwo
         wG/ktx/3e15KGnj+Q2xmR93kS31q4oGxB/HM6ehTH2FJyqn9a4HUco/yUYd/cPb9iX3T
         +tWHSc9kq7wHPQKUpfjR9dyWM0A7ID2k7i2Qhi0sKvAttY086Czq/3WMS6btz0RJg+Jz
         ZoWouc606jo1xYInUo2b9auCLaby+T++nrlTwslMGaXmsuOP4R1t823FE8nQYybqgcls
         jGam9bG5/TmdU571j2wSnoMThYFkdienSJw521BjhHU0/fZ4lZ5HjvsZ4n93kaEFasEN
         1CjA==
Received: by 10.50.194.138 with SMTP id hw10mr7310821igc.11.1349136875516;
 Mon, 01 Oct 2012 17:14:35 -0700 (PDT)
Received: by 10.50.101.230 with HTTP; Mon, 1 Oct 2012 17:14:35 -0700 (PDT)
In-Reply-To: <1349126586-755-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206779>

On Mon, Oct 1, 2012 at 5:23 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> From: "Shawn O. Pearce" <spearce@spearce.org>
>
> When libcurl fails to connect to an SSL server always retry the
> request once. Since the connection failed before the HTTP headers
> can be sent, no data has exchanged hands, so the remote side has
> not learned of the request and will not perform it twice.
>
> In the wild we have seen git-remote-https fail to connect to
> some load-balanced SSL servers sporadically, while modern popular
> browsers (e.g. Firefox and Chromium) have no trouble with the same
> server pool.
>
> Lets assume the site operators (Hi Google!) have a clue and are
> doing everything they already can to ensure secure, successful
> SSL connections from a wide range of HTTP clients. Implementing a
> single level of retry in the client can make it more robust against
> transient failure modes.

Ok, this begs for some background info...
@Dayjob one of the many things I do is mange our load balancers
(redundant pair in our case). If the attempted SSL connections in one
"bin" (time-slot) exceeds the licensed size of that "bin" then the
excess attempts are just "dropped on the floor." Normal web browsers
detect this initial failure and try again. This may be implemented
internally=E2=80=94I haven't checked.

Google, as I am sure you are well aware, doesn't rely upon a
traditional L2/L3 network level load balancing architecture.
Therefore, I would not attempt to argue that the results that apply to
their systems would apply much of anywhere else. (They have done
presentations publicly, which are archived on the 'net, about how they
do things.)

--=20
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
