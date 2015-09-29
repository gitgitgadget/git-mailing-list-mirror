From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: broken racy detection and performance issues with nanosecond
 file times
Date: Tue, 29 Sep 2015 13:28:20 +0200
Message-ID: <560A75D4.9000206@gmail.com>
References: <5605D88A.20104@gmail.com> <xmqqbncme95a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 13:28:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgt5J-000880-3w
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 13:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbbI2L21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 07:28:27 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35655 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964871AbbI2L2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 07:28:22 -0400
Received: by wicge5 with SMTP id ge5so145801951wic.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 04:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=N2Z9RWg/1hiKpOzrfiEavvmFhg/D0WRQl/RPRXhzl9M=;
        b=kw3MremDpWcSbPBVRiwr4NEJVA913T6IH0sJWIZ1gx549jG0w9K0+YUKrywRTe7blO
         9nDqER2uNm5ds9VrV7uBMnH8KLui8G0D0GP8bWBOzyMnUhljqkptofx+LqFXg0NyuIWz
         jks4QJJKV7TwspBlB82HDNV3wlZUA1M1srYJTAqcqNK0fUjqtdRTe1cz0R8zIBRiLJWG
         PfyJ49xuvyFWW0xyZFVGDwAD8teewjAmLah7qmLCixU2r3/H68qYaYmE/FB1PBtrcUvz
         GFzTZ8P/A0s05O14ScaIoL18bhj3rcSZd6ueMRGnMUp+K4We0QCz+Mtpiis5Kdf6iaq6
         hT6Q==
X-Received: by 10.194.190.75 with SMTP id go11mr26944085wjc.80.1443526101297;
        Tue, 29 Sep 2015 04:28:21 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by smtp.googlemail.com with ESMTPSA id i10sm6259974wjz.41.2015.09.29.04.28.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2015 04:28:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqbncme95a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278818>

Am 28.09.2015 um 19:38 schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Problem 1: Failure to detect racy files (without USE_NSEC)
>> ==========================================================
>>
>> Git may not detect racy changes when 'update-index' runs in parallel
>> to work tree updates.
>>
>> Consider this (where timestamps are t<seconds>.<nanoseconds>):
>>
>>  t0.0$ echo "foo" > file1
>>  t0.1$ git update-index file1 &  # runs in background
> 
> I just wonder after looking at the ampersand here ...
> 
>> Please let me know what you think of this...maybe I've completely
>> screwed up and can no longer see the forest for all the trees.
> 
> ... if your task would become much simpler if you declare "once you
> give Git the control, do not muck with the repository until you get
> the control back".
> 

This is just to illustrate the problem. GUI-based applications will
often do things in the background that you cannot control. E.g. gitk,
git gui, Eclipse or TortoiseGit don't tell you when and how long you
shouldn't touch the working copy. At the same time, IntelliJ IDEA and
most office suits have the auto-save feature turned on by default,
and you cannot tell them when *not* to auto-save.

It may still be quite unlikely that this happens (you need two
changes within a second, without changing the file size), but *if*
it happens, the user may not even notice. And as git trusts the
false stat data blindly, the problem won't go away automatically.
You can mark all entries racy by setting index mtime to some value
far in the past, but this implies that you noticed that something
was wrong...
