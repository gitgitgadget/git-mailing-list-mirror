From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Sat, 6 Aug 2011 14:05:31 -0700
Message-ID: <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 23:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpo50-0006xB-OH
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 23:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064Ab1HFVFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 17:05:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63025 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab1HFVFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2011 17:05:53 -0400
Received: by fxh19 with SMTP id 19so3976455fxh.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 14:05:51 -0700 (PDT)
Received: by 10.204.34.215 with SMTP id m23mr1185541bkd.218.1312664751340;
 Sat, 06 Aug 2011 14:05:51 -0700 (PDT)
Received: by 10.204.124.18 with HTTP; Sat, 6 Aug 2011 14:05:31 -0700 (PDT)
In-Reply-To: <7vbow337gx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178891>

On Fri, Aug 5, 2011 at 13:54, Junio C Hamano <gitster@pobox.com> wrote:
> A request to fetch from a client over smart HTTP protocol is served i=
n
> multiple steps. In the first round, the server side shows the set of =
refs
> it has and their values, and the client picks from them and sends "I =
want
> to fetch the history leading to these commits".
>
> When the server tries to respond to this second request, its refs may=
 have
> progressed by a push from elsewhere. By design, we do not allow fetch=
ing
> objects that are not at the tip of an advertised ref, and the server
> rejects such a request. The client needs to try again, which is not i=
deal
> especially for a busy server.
>
> Teach --allow-non-tip option to upload-pack (which is the workhorse d=
riven
> by git-daemon and smart http server interface) that lets it server co=
mmits
> that are not at the tip of any advertised ref, as long as they are
> reachable from advertised refs.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =A0* I'll leave it to interested parties who are more qualified than =
I am to
> =A0 update remote-curl nor http-backend to actually ask upload-pack t=
o use
> =A0 this new logic ;-)

Why a new --allow-non-tip flag? Why not always do this with the
existing --stateless-rpc flag? I think the only time it is reasonable
to allow a non-tip want line is during the smart HTTP usage where the
request has spanned processes and the references may have moved in the
interm. Over a git:// or SSH where its the same server process and the
refs were cached at startup (and thus cannot move), it isn't
reasonable to allow a non-tip want.

Otherwise the patch looks good to me. This should fix some issues with
very busy repositories being fetched over smart HTTP.

--=20
Shawn.
