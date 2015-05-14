From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with rerere forget
Date: Thu, 14 May 2015 12:19:25 -0700
Message-ID: <xmqqr3qjj7b6.fsf@gitster.dls.corp.google.com>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
	<xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
	<20150514191637.GA9329@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex Coppens <alex@nativetouch.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 21:19:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsyfM-0007oy-58
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbbENTT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:19:28 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36017 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964894AbbENTT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:19:27 -0400
Received: by iepk2 with SMTP id k2so67967684iep.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=snyIf9QGwJTuWzSF7cTw3VMLvLUEsR9oCLHEdUGAYAU=;
        b=BmbIDBJE8Xo+j1pZmrr38qbZ+1i/11ong+/IFaOdoO4nYeguB9ZO9gJPQpsP5hG6/q
         O5LBlNxc0bJ8fjO3IRmNSh0OpenLUcxhjJ9DvEezSjWV/Htxy1FRVRcU+DU1W5Pb5Be9
         Ck1tpl3OqEbTCNmbyFVqt2IYNekd+HROhDdleK5WRC/hea2475+51+vpgq1XqFhV+yGY
         1LINsVrxLTuwCPJruOi6LKqjcFxeNjATnabSrdR9C8eyc+RnCGmNJ2qav9DZoaDRCz78
         5/5zjSR+fXo2EIWfeTgt2h6X2clgTK8p9KuFRCeLWbjwsBcZ9IaTzyRr/a5GpUUslEdL
         JCMw==
X-Received: by 10.107.12.158 with SMTP id 30mr7177858iom.61.1431631166500;
        Thu, 14 May 2015 12:19:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id l30sm17111444iod.12.2015.05.14.12.19.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 12:19:25 -0700 (PDT)
In-Reply-To: <20150514191637.GA9329@peff.net> (Jeff King's message of "Thu, 14
	May 2015 15:16:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269072>

Jeff King <peff@peff.net> writes:

> On Thu, May 14, 2015 at 11:49:12AM -0700, Junio C Hamano wrote:
>
>> Alex Coppens <alex@nativetouch.com> writes:
>> 
>> > git rerere forget path_to_file/file.js
>> >
>> > fatal: BUG: attempt to commit unlocked object
>> 
>> That comes from commit_lock_file(); I think rerere.c:write_rr()
>> has a call to that function and I suspect that is the call that is
>> giving the above message.
>> 
>> Is there any other process that is mucking with your .git/index file
>> while you are running the command?
>
> This seems much easier to reproduce:
>
>   $ git init -q
>   $ git rerere forget foo
>   fatal: BUG: attempt to commit unlocked object
>
> It looks like we need to pay more attention to the return value of
> setup_rerere, which is what is supposed to take the lock.

Good spotting.  The normal rerere does check, but rerere-forget
codepath seems to forget it.
