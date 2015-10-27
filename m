From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the namespace
Date: Tue, 27 Oct 2015 15:32:07 +0100
Message-ID: <20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
 <xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
 <20151027053916.3030.8259@typhoon.lan>
 <20151027055911.4877.94179@typhoon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr5IR-0008Qn-Hq
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 15:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbbJ0OcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 10:32:15 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:10940 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbbJ0OcO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 10:32:14 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id bd997153;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 27 Oct 2015 15:32:10 +0100 (CET)
In-Reply-To: <20151027055911.4877.94179@typhoon.lan>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280265>

On Tue, 27 Oct 2015 at 06:59:11, Lukas Fleischer wrote:
> [...]
> On second thought, it might be possible to overwrite the value of
> transfer.hiderefs using the -c command line option. If we combine that
> with the negative patterns supported by hiderefs, we might get a
> solution that is clean and that avoids race conditions. I will check
> whether that works with git-http-backend as well and will report back.
> 
> Thanks for the pointer!

Using receive.hideRefs seems to work but there are two minor issues:

1. There does not seem to be a way to pass configuration parameters to
   git-shell commands. Right now, the only way to work around this seems
   to write a wrapper script around git-shell that catches
   git-receive-pack commands and executes something like
   
       git -c receive.hideRefs=[...] receive-pack [...]
   
   instead of forwarding those commands to git-shell. How about allowing
   to overwrite configuration parameters via an environment variable?
   Has that been discussed before?

2. transfer.hideRefs and receive.hideRefs do not seem to work with Git
   namespaces in general. show_ref_cb() replaces each ref outside the
   current namespace with ".have" before passing it to show_ref() which
   in turn performs the ref_is_hidden() check. This has the nice side
   effect that receive.hideRefs=.have does exactly what I want, however
   it also means that hideRefs feature does not allow for excluding only
   specific tags outside the current namespace. Is that intended? Can we
   rely on Git always looking for ".have" in the hideRefs list in this
   case? Should the documentation be updated?

Regards,
Lukas
