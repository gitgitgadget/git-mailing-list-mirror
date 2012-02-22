From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches fail
Date: Wed, 22 Feb 2012 07:22:10 -0800
Message-ID: <CAJo=hJsFDrt4rsxVAnx86bxZDY3yfWc1=GDd8opUU+9z7esLnw@mail.gmail.com>
References: <8739bacpql.fsf@thomas.inf.ethz.ch> <1327079011-24788-1-git-send-email-spearce@spearce.org>
 <20120222101302.GA11606@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 16:22:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0E1c-0005vM-HZ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 16:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab2BVPWb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 10:22:31 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49386 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab2BVPWa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 10:22:30 -0500
Received: by pbcun15 with SMTP id un15so261275pbc.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 07:22:30 -0800 (PST)
Received-SPF: pass (google.com: domain of spearce@spearce.org designates 10.68.74.72 as permitted sender) client-ip=10.68.74.72;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of spearce@spearce.org designates 10.68.74.72 as permitted sender) smtp.mail=spearce@spearce.org; dkim=pass header.i=spearce@spearce.org
Received: from mr.google.com ([10.68.74.72])
        by 10.68.74.72 with SMTP id r8mr83158936pbv.86.1329924150167 (num_hops = 1);
        Wed, 22 Feb 2012 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=j6+HZBhuQw/8X3Rl0Vm5FoxsiBgkTsa19A/E0qb9Y7I=;
        b=fScb/1QV/SFW+hceksASET/3H/+sCXFAEj+a4AONryvKrXpKmwcHm5rc6M6GwUjUtn
         9B94U2xFRUfBc/Jlogcnfw/hVTFqLulxhEISY6Dvibtvo6/IYPBLxq+v1h3SlnEfL2RH
         Gl0/e0USiTjDD8ridx9mt6NKjYvZAqhxNRIAw=
Received: by 10.68.74.72 with SMTP id r8mr68438900pbv.86.1329924150100; Wed,
 22 Feb 2012 07:22:30 -0800 (PST)
Received: by 10.68.64.34 with HTTP; Wed, 22 Feb 2012 07:22:10 -0800 (PST)
In-Reply-To: <20120222101302.GA11606@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlvQo1DgW6NwUZGQEeRBTZunEHlswV03aAOTf5ERFEEpxxKd/2UXofW8VtFt3cQYlYIDfxz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191259>

On Wed, Feb 22, 2012 at 02:13, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 20, 2012 at 09:03:31AM -0800, Shawn O. Pearce wrote:
> This hunk is causing intermittent failures of t5541 for me, especiall=
y
> when the system is under heavy load (e.g., make -j32 test).
=2E..
> @@ -220,15 +221,21 @@ static struct child_process *get_helper(struct =
transport *transport)
> =A0static int disconnect_helper(struct transport *transport)
> =A0{
> =A0 =A0 =A0 =A0struct helper_data *data =3D transport->data;
> - =A0 =A0 =A0 struct strbuf buf =3D STRBUF_INIT;
> =A0 =A0 =A0 =A0int res =3D 0;
>
> =A0 =A0 =A0 =A0if (data->helper) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (debug)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "Debug=
: Disconnecting.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!data->no_disconnect_req) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addf(&buf, "\n")=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sendline(data, &buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Ignore write error=
s; there's nothing we can do,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* since we're about =
to close the pipe anyway. And the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* most likely error =
is EPIPE due to the helper dying
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to report an error=
 itself.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sigchain_push(SIGPIPE, =
SIG_IGN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xwrite(data->helper->in=
, "\n", 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sigchain_pop(SIGPIPE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(data->helper->in);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(data->helper->out);
>
> which makes the t5541 failures go away for me. What do you think?

This sounds right to me. Its unfortunate that we missed the error
status output when we built the remote helper protocol, but your patch
above might be the best we can do now.

Eh, well, actually we could have the helper advertise a new capability
that can be enabled to return exit status. That is a much bigger
change, and even if we do it for remote-curl (since that is in tree
and easy to update) we still need your patch for the same race
condition for out of tree helpers (which Google actually has so I care
about out of tree helpers too).
