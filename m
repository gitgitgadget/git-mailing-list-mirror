From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/7] sha1_file: keep track of where an SHA-1 object comes from
Date: Fri, 25 Jan 2013 08:38:38 +0700
Message-ID: <CACsJy8Ag6v7wUnupRwGid26AUzgZ=WbdA5F-MpjUv5ktaj5Asg@mail.gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com> <7va9rycw4t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 02:39:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyYGU-0004kG-6v
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 02:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab3AYBjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 20:39:13 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:46058 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab3AYBjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 20:39:10 -0500
Received: by mail-oa0-f54.google.com with SMTP id n9so10915238oag.13
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 17:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1U+mpm+3nQGJ4MfLgZoq3980WvXiM1t1osY+w+Uo4bY=;
        b=vCpoIQWv4GRA6hjVr0aOs7gAY8HkXh9C/n+eaL8t+8DSNZ0PP+3is5xZKF0o2VrGrW
         PJJK3DX+WyjPU2AeGTlV3Z6MEqxcmwjQqTjbGyRzT8W72nn9v5Dk1dkFBHPBu0FB3Pr8
         B4i9tSBer+waodYywKdJiOEHb4PBde/KjhgsZUb2H//+mFd/rADjS4c+5wYGEFNhlyLf
         99g6JFeAMJm0H48Fh9X65Xyc0BW+DHafF7SUNCHHEhs0LuR6J23fyDcxvsadvkQDIolq
         CKjtz+pjZQIobIg6ly0aJyvOvyChuLMi+YkZonEa7dpi5Wlyo2NbL8dbGW7PO+lg3m6+
         /Iyw==
X-Received: by 10.60.22.164 with SMTP id e4mr3175086oef.87.1359077949361; Thu,
 24 Jan 2013 17:39:09 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 24 Jan 2013 17:38:38 -0800 (PST)
In-Reply-To: <7va9rycw4t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214477>

On Fri, Jan 25, 2013 at 12:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>  How about this way instead: we keep track of where objects come from
>>  so we can verify object source when we create or update something
>>  that contains SHA-1.
>
> The overall approach taken by this series may be worth considering, but
> I do not think the check implemented here is correct.
>
> An object may be found in an alternate odb but we may also have our
> own copy of the same object.  You need to prove that a suspicious
> object is visible to us *ONLY* through add_submodule_odb().

The way alt odbs are linked (new odbs area always at the end), if we
have the same copy, their copy will never be read (we check out alt
odbs from head to tail). So those duplicate suspicious objects are
actually invisible to us.

> Once you do add_submodule_odb() to contaminate our object pool, you
> make everything a suspicious object that needs to be checked; that
> is the worst part of the story.

And because we never really touch their alt copy, the returned alt
source is "ours", trusted and not checked. The check should only occur
on objects that we do not have.
-- 
Duy
