From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCHv2] lis3lv02d: support both one- and two-byte sensors
Date: Wed, 11 Feb 2009 00:46:24 +0100
Message-ID: <499211D0.3090705@tremplin-utc.net>
References: <1234309249-13672-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756846AbZBJXqt@vger.kernel.org Wed Feb 11 00:48:17 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756846AbZBJXqt@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2Kt-0004Ak-MN
	for glk-linux-kernel-3@gmane.org; Wed, 11 Feb 2009 00:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846AbZBJXqt (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 10 Feb 2009 18:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbZBJXqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2009 18:46:39 -0500
Received: from mailservice.tudelft.nl ([130.161.131.5]:22252 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbZBJXqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2009 18:46:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by rav.antivirus (Postfix) with ESMTP id 7B57F8006D;
	Wed, 11 Feb 2009 00:46:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at tudelft.nl
X-Spam-Flag: NO
X-Spam-Score: -12.589
X-Spam-Level: 
X-Spam-Status: No, score=-12.589 tagged_above=-99 required=5
	tests=[BAYES_00=-2.599, PROLO_LEO3=0.01, TUD_REL01=-10]
Received: from mailservice.tudelft.nl ([127.0.0.1])
	by localhost (tudelft.nl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Czf3hIK68jCS; Wed, 11 Feb 2009 00:46:28 +0100 (CET)
Received: from smtp-a.tudelft.nl (smtp-a.tudelft.nl [130.161.129.18])
	by mx4.tudelft.nl (Postfix) with ESMTP id 6BEEB8009F;
	Wed, 11 Feb 2009 00:46:28 +0100 (CET)
Received: from [192.168.10.167] (63-103-dsl.ipact.nl [84.35.103.63])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-a.tudelft.nl (Postfix) with ESMTP id 0E975B3A62;
	Wed, 11 Feb 2009 00:46:28 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081231 Mandriva/2.0.0.19-1mdv2009.1 (2009.1) Thunderbird/2.0.0.19 Mnenhy/0.7.6.666
In-Reply-To: <1234309249-13672-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109349>

Giuseppe Bilotta schreef:
> Sensors responding with 0x3B to WHO_AM_I only have one data register per
> direction, thus returning a signed byte from the position which is
> occupied by the MSB in sensors responding with 0x3A.
> 
> We support both kind of sensors by checking for the sensor type on init
> and defining appropriate data-access routines and sensor limits (for the
> joystick) depending on what we find.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> 
> This is the other version of the patch, and it changes access to use the
> base address from the 8-bit, so the 16-bit routine is changed to access
> the PREVIOUS byte for the LSB.
> 
> Choose whichever of the patches is deemed more correct 8-)
> 
> Note that both patches are based off Linus tree, so I don't know how
> they cope with Pavel's "don't touch too much on init" one. I'll try to
> work out a patch on top of that too.
Yes, great, and this one looks even better than v1 :-)
However I'm not sure about the conversion between s8 and s16:

> +static s16 lis3lv02d_read_8(acpi_handle handle, int reg)
> +{
> +	u8 lo;
> +	adev.read(handle, reg, &lo);
> +	return *((s8*)(&lo));
> +}
Does it really extend the sign to 16 bits? I would have written it this way:
+static s16 lis3lv02d_read_8(acpi_handle handle, int reg)
+{
+	s8 lo;
+	adev.read(handle, reg, &lo);
+	return (s16)lo;
+}
Doesn't it work better?

Eric
