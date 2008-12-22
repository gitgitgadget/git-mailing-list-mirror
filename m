From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: add special '-' blob reference to use the previous one.
Date: Mon, 22 Dec 2008 04:10:34 +0200
Message-ID: <94a0d4530812211810x7d9772cbq9934dd6ea6e7f62a@mail.gmail.com>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
	 <1229825502-963-2-git-send-email-felipe.contreras@gmail.com>
	 <20081221221149.GB17355@spearce.org>
	 <7vlju9kvyg.fsf@gitster.siamese.dyndns.org>
	 <20081221223335.GF17355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 03:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEaHK-0005pF-90
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 03:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbYLVCKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 21:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYLVCKh
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 21:10:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:7118 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbYLVCKg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 21:10:36 -0500
Received: by fg-out-1718.google.com with SMTP id 19so710075fgg.17
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 18:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VFRLvfteFHsBfTKkMFEIet3wNQ6h/k/nRFqEenNRf9k=;
        b=oyxgRYgR+NchkBmQU5+Z7rT+zRucIspsGpYI//39PVFVxzX3WjOU0oSqFz8sW/NvP5
         EEKCBP6VaiC9+OjS2FTgDAIctOvbX7G+21r1rBcyNnLSObPL+7Oq5uSZf9h8gEaMpgpB
         xza3jQ3zwLedfWDGg8MLDFG/nqVwrPuVz3w0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oHWfNfcxLWA0ssFkZ0WSHSXxcs3wAj/FAPhp72GUVuekVdfQUlf4P+zlNxX9poOKMa
         2XTqjaykB8uxnPSQa4l0xngvEEYP0qMfQ66UCSDuUDoCzeuQIdCM6sqKa08rnBpB6Mw8
         TT7/vkVez9moI93MReOBI3mJHIqK6prZlIgZw=
Received: by 10.86.62.3 with SMTP id k3mr3312280fga.47.1229911834928;
        Sun, 21 Dec 2008 18:10:34 -0800 (PST)
Received: by 10.86.77.17 with HTTP; Sun, 21 Dec 2008 18:10:34 -0800 (PST)
In-Reply-To: <20081221223335.GF17355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103737>

On Mon, Dec 22, 2008 at 12:33 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>
>> > Hmph, so if create a new path with a blob of "-" the repository
>> > will be corrupt because the zero id was used and error was produced.
>> >
>> > Actually I think you have the same bug in the prior patch with the
>> > mode being inherited.  I wonder if we shouldn't put error checking
>> > in too to validate that versions[0] describes a file entry.
>>
>> Why are these patches necessary?

Yeah, I realized I didn't explain that after sending the patches.

>> The proposed commit message describes what it does, but does not give hint
>> to even guess being able to use this new feature helps in what situation.
>> As far as I can see, these changes allow the exporter to say "this aspect
>> of the new data is the same as the previous one", but I thought that the
>> way in which fast-import works already revolves around "you have this
>> tree, and the next tree is different from it in this and that way."  Why
>> does one need be able to mention "this is the same as the previous one"
>> explicitly in the first place?
>
> Hmm.  Actually, imagine you were dumping from git-diff output style
> stream into a fast-import stream.
>
> If a file changes only content, the mode is shown in the index line.
> Yay us.  But what if the index line wasn't present in the diff? You
> don't know the prior mode of the file, but you do have its content.
>
> If a file changes only mode, we get no content hints in the diff.
> How do you send that into fast-import without making the frontend
> keep track of every path's current mode?
>
> Though I agree, these details should be described in the commit
> messages, not left as an exercise for the maintainer to make up.

Exactly. That's what happens with monotone; you usually have the
contents or the new mode, but not both at the same time.

-- 
Felipe Contreras
