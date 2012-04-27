From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Fri, 27 Apr 2012 08:07:55 -0700
Message-ID: <xmqqmx5x9pro.fsf@junio.mtv.corp.google.com>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
	<xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
	<87d36uxzfw.fsf@rho.meyering.net>
	<xmqq62cma2uo.fsf@junio.mtv.corp.google.com> <4F9A972E.7050401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, Marcus Karlsson <mk@acc.umu.se>,
	git list <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Apr 27 17:08:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNmmB-0003tv-BC
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 17:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760335Ab2D0PH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 11:07:58 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:43574 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760176Ab2D0PH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 11:07:58 -0400
Received: by wibhj13 with SMTP id hj13so45318wib.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 08:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=dauypdyphJRjIyolvDTyA4EPrSHJm8VdLy26SY/ViN0=;
        b=jMIdR6Zmj5MFKC6i9IF0V8+v/cOtIc7etRNEYRL2s81bFa8fQY6b9qKNJdiJuyQCXT
         BRWu416Sjwz9aeZhpWGpDwWLd8gEIOrKBBhLb+Me414azxuqI2+VEP/8knriryGxYv/X
         2pKIRhXVyr6GlV5ZMh/aNoFEDLvN89Eu/REFbSUVCml8UIo9leELf0O5FD6YSAOJpsbu
         fBQvqUIDJfGkmkmVCZ6ZlzyssFGH8oKGuCu5Dh6mE3coUHcBqFYeRw6dYiSy3SXAhRrO
         JxHJ0o3H5WWD1il0vPRI7bgZI6crbQrr5tTnNAbSuPDhJJ4BYA/03QYgUnXosmtaImff
         75eA==
Received: by 10.213.27.15 with SMTP id g15mr654130ebc.7.1335539276842;
        Fri, 27 Apr 2012 08:07:56 -0700 (PDT)
Received: by 10.213.27.15 with SMTP id g15mr654110ebc.7.1335539276635;
        Fri, 27 Apr 2012 08:07:56 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si6446930eei.3.2012.04.27.08.07.56
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 08:07:56 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 6FE0E5C375E;
	Fri, 27 Apr 2012 08:07:56 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id D4E7EE125C; Fri, 27 Apr 2012 08:07:55 -0700 (PDT)
In-Reply-To: <4F9A972E.7050401@op5.se> (Andreas Ericsson's message of "Fri, 27
	Apr 2012 14:55:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkX6tDwGXC5gTp2AbKy3BMWH3E2qrjP+livzQCDFISxrJPBv1JymIOwSJcsTMgO8NkD/h+qKS4FLRi60ItL0tHiBovEcVIE5XN/Cv1WXyPh6hUqDL0TcM7AUJdCnycYi090Cj+IVZKb7zN9k22B/nsbvZZUjdeAhusdw1J9JcFDigG0cRI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196476>

Andreas Ericsson <ae@op5.se> writes:

>> I am not good at names, but strbuf_terminate_with(&buffer2, '/')
>> perhaps?
>> 
> "terminate" sounds pretty final though.

Yeah, but that function is adding a record terminator to the buffer, so...

> How about strbuf_ensure_suffixch()?
> It embeds the 'ch', marking it as a char argument...

Perhaps.
