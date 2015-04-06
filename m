From: David Turner <dturner@twopensource.com>
Subject: Re: Freeing struct lock_file?
Date: Mon, 06 Apr 2015 14:02:00 -0400
Organization: Twitter
Message-ID: <1428343320.3560.11.camel@ubuntu>
References: <1428097515.31333.2.camel@ubuntu>
		 <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
	 <1428107083.31333.11.camel@ubuntu> <551F8FC3.8010104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 20:02:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfBLh-00011i-2p
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 20:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbbDFSCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 14:02:08 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35134 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbDFSCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 14:02:07 -0400
Received: by qgej70 with SMTP id j70so13081234qge.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 11:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=fErqPb4f246eXVOzKXKuw9ZKFlNEFMVQwaUOHn5YArI=;
        b=mgcXRCGE0VnFpBWHwwKnqlWaVAcE7cVvDo0NxKIsXWO98mv5tSp+CNSWjh4biPl4hF
         xgSxHHM21LWeogfvxgQq9RULaNSLecnVlq9inLS0VWEXDuO6NoSi5yOVJUMxY5nl1as/
         ZXHH977X5ugAtNbjIdgXPDCHubtLXGHUk4ffXL9RFfDOyuNyMWgrc+pFQ/62nuTp6OE3
         sBNMrZodgaCDLYbCq+T32x9RkQzDBOXWhHAlCrVo8Sr40ivab6xXcBOpoWMYjAy7hWvB
         IYWo4N6xjs2AFHzHGylzl2NUBkxRtPixVxZ+eINpRuFG/gpVg4sJkZKDnQ9dRrnTxMhF
         uvpA==
X-Gm-Message-State: ALoCoQkfgL6cSZA/IQPbTAhvCn2yf/uQmkioHFxWMAk9f3Is5Ro0y4egKtcD+rDtoAlD5G/mrJ2i
X-Received: by 10.140.237.194 with SMTP id i185mr19121280qhc.53.1428343326409;
        Mon, 06 Apr 2015 11:02:06 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id c135sm3633008qka.21.2015.04.06.11.02.02
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 11:02:05 -0700 (PDT)
In-Reply-To: <551F8FC3.8010104@web.de>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266876>

On Sat, 2015-04-04 at 09:16 +0200, Torsten B=C3=B6gershausen wrote:
> On 2015-04-04 02.24, David Turner wrote:
> > On Fri, 2015-04-03 at 15:01 -0700, Junio C Hamano wrote:
> >> David Turner <dturner@twopensource.com> writes:
> >>
> >>> Why is it impossible to free struct lock_files?  I understand tha=
t they
> >>> become part of a linked list, and that there's an atexit handler =
that
> >>> goes over that list.  But couldn't we just remove them from the l=
inked
> >>> list and then free them?=20
> >>
> >> I suspect that the code is worried about getting a signal, while i=
t
> >> is manipulating the linked list, and then cause the atexit handler
> >> to walk a list that is in a broken state.
> >=20
> > This is technically possible, but practically unlikely: aligned
> > pointer-sized writes are atomic on very nearly every processor, and=
 that
> > is all that is required to remove an item from a linked list safely=
 in
> > this case (though not, of course, in the general multi-threaded cas=
e).
> >=20
> > But I can see why git wouldn't want to depend on that behavior. C11=
 has
> > a way to do this safely, but AIUI, git doesn't want to move to C99 =
let
> > alone C11.  So I guess this will just have to remain the way it is.
> >=20
> If you insist on using C11, may be.
>=20
> But if there is an implementation that is #ifdef'ed and only enabled =
for
> "known to work processors" and a no-op for the others, why not ?
>=20
> Do you have anything in special in mind ?
> A "git diff" may be a start for a patch series..

I haven't written any code for this yet.  I wanted to understand the
current code first.

My major worry is be that the code would be somewhat fragile as it
depends on not just the processor, but also the C compiler's structure
packing rules, which are implementation-dependent.  In practice, major
compilers' rules are safe, but it's annoying to have to depend on
(especially since any bugs would be incredibly difficult to reproduce).
