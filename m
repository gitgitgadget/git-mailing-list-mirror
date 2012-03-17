From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Edit a rerere conflict resolution
Date: Sat, 17 Mar 2012 12:03:21 +0100
Message-ID: <4F646F79.9090408@lyx.org>
References: <4F5E4B20.5080709@lyx.org> <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F636227.2060102@lyx.org> <7vaa3gilg7.fsf@alter.siamese.dyndns.org> <4F636700.2090105@lyx.org> <7vvcm4h61a.fsf@alter.siamese.dyndns.org> <7vobrwh4zc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 12:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8rQ5-0001ux-DX
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 12:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903Ab2CQLDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 07:03:25 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39380 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab2CQLDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 07:03:24 -0400
Received: by eekc41 with SMTP id c41so2380968eek.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 04:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=ek8jOBdusM6TjFGhkZQTJ/u6svnTiG4GSb5saXX8Lqo=;
        b=X9VFZ8YwwbEV0vDEWWrDQLWQygZ6hNqq5R/lYXyjV3MCFOshfWsSScV9r8F5j+Bjzi
         ahzwk4mZQlVY/AMjMyxWKFbGjfx/gmh+Qbp2hxqDR+USKfgusq/7CYg3orS0IoXqEGrk
         Io5PUfdtjhv2bm/aw7JZj7+0a6RBkEdi3lbLrDSMr5vXg65TP+JXBR0JYi9FO2aTB40i
         4gUgdg9Kxv1LsZqUVaZdnZvcgmarwFZ4X44AZLTK7JIEGAtbeNSO0GFtj551Atdw19Iy
         OcGsPB61VfLRLkxL9M494TBH1BxrmN754TeHe63wOkSRc8vE2wVOHeSL74VASx07xzzE
         FMnA==
Received: by 10.14.96.6 with SMTP id q6mr714575eef.6.1331982202694;
        Sat, 17 Mar 2012 04:03:22 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id r44sm27793926eef.2.2012.03.17.04.03.21
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 04:03:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vobrwh4zc.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQm9uuCjHHoMg6frxcFUe5AbBZrKZDVH5HOqOd/ULKDRkEpQjcyKY/WdAJvP6I/VI0SMIebM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193319>

Op 16-3-2012 17:42, Junio C Hamano schreef:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>>
>>> No, I turned rerere.autoupdate off. Proven in the above by the line
>>> "Resolved... " instead of "Staged...".
>> Yeah, actually I just tried and the procedure works with or without
>> autoupdate for me.
>>
>> So there is something different between our setup (or the nature of the
>> conflict), but I do not know what it is offhand.
> The last message from me on this topic for now as I'll be a bit too busy,
> but a wild guess/hunch: grep NEEDSWORK near rerere.c::handle_cache()?
>
> I suspect that we might need to also update this function to handle "both
> sides added, but differently" case, as we do so in check_one_conflict()
> these days, but for Vincent's particular case that shouldn't be the cause.

Yes, the problem is with the renormalization (of eol style) in handle_cache.

When I've set 'core.autocrlf = true', 'git rerere forget' fails because 
it does not renormalize. The sha1 of the merge conflict is computed with 
'crlf' line-ending in handle_file, but with 'lf' line-ending in 
handle_cache.

Even if I change the code to do the renormalization, it fails. In 
'renormalize_buffer; , the buffer is converted to 'crlf' by 
'convert_to_working_tree_internal', but at the end it is converted back 
to 'lf' by 'convert_to_git'

I don't understand the logic of 'convert_to_git' and 'crlf_to_git' well 
enough to pinpoint what is going wrong exactly.

Vincent
