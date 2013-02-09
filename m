From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sat, 9 Feb 2013 17:35:55 +0530
Message-ID: <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 13:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U49Cf-0007EI-5b
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 13:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab3BIMGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 07:06:19 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51838 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab3BIMGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 07:06:17 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so6101200iea.33
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 04:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6MkOnEEM1iwVDpChbyfrU42NxYH5CCfi32xPP9m/YOc=;
        b=DXqmFTVDh/7ad9gYi5ZO1ERBrvRVOiyEd518fE4yEHqi9BPuchF8HT82AillUZwj4U
         r10FGFoBm8NRgIiGtRE6IdSmHSxxz8EqtqwKee5JZm2U2gKzC/ga8fLH2hT68vAXFrdi
         +wdtJnKtJDpG2EtA3vC0C3KWWx80jC26B4/g0S5GfYw5P4QBSM++xdRBWHME/fU2RgYT
         XgSd5M3Z6uOd2Dbtx0c7j5DA/1RK/1H69KCHS4qktTDufhmBab5r3ZJwkKO/Y1rQS2EP
         AeFTHoJFR9Ewwp/e5oKUuuDgOREqAr6HIzaqw4RSDKcEVufXNaJvvFD2cFrPuokJTJj6
         F0SQ==
X-Received: by 10.50.189.163 with SMTP id gj3mr7657491igc.14.1360411575441;
 Sat, 09 Feb 2013 04:06:15 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Sat, 9 Feb 2013 04:05:55 -0800 (PST)
In-Reply-To: <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215859>

Robert Zeh wrote:
> From the description so far, I have some question: how does the daemon get started and stopped?  Is there one per repository ...

What about getting systemd to watch everything for us?  Then we can
just have one daemon reporting filesystem changes over one global
socket.  It's API should be the inotify subset:

   systemd_add_watch
   systemd_remove_watch

Except systemd_add_watch also accepts a UNIX socket to send lstat
events to.  Our preload_index() is just reduced to making one
systemd_add_watch() call the very first time and updating the index as
necessary.  Now, what about desktops with huge uptimes (like mine)?
Won't they get polluted with too many useless watches over time?
Simple: timeout.  If nobody reads from the UNIX socket for two hours
after a systemd_add_watch, execute systemd_remove_watch automatically.

Someone must implement a similar daemon on other platforms reporting
information in exactly the same way (although with different
internals).  IP sockets are system-wide and all platforms have them,
so the communication channel is also standardized.

This is much better than Junio's suggestion to study possible
implementations on all platforms and designing a generic daemon/
communication channel.  That's no weekend project.
