From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length calculation
Date: Wed, 16 Jan 2013 08:08:03 +0700
Message-ID: <CACsJy8Bn4GKJzi4n5cMPp+26dovT795nUqcXGNLgapf+r_PFCw@mail.gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com> <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvHUt-0004o4-NK
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 02:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468Ab3APBIf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 20:08:35 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:61798 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147Ab3APBIe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 20:08:34 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so815682obb.7
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZKFPKrEkOBytWFeIGAircmc2YbX+HWu7tNQTQ9BeyKo=;
        b=G/3qtIYjujvT+qIs/i7/ZLWtCW1tif2r4v1CDqBi5yJi8lTvpMA9mF0BNdxcMVNxeQ
         DdOjfRguuGWFlKS/vt1dwHlqxE2jXUT2VHSDrAWVYSfap0HbUIQw9pVYnRMGYJGVWu0l
         o5QSVxqQR1T816bPVcU5Tg0cadZEEgnMV+3stuYE7541l5h8eswFPuPIDwxHh9MVftCe
         fUCppDBVhyRFlliBZhF03tomDxTlpA4Vllp4hQ8n0Bs3xspfyYjSgNcXjBMeZJcoVKqp
         SLUdL0mn2JuY37UGK4HKuKQ5UT6YKSLlCJH0gXNvaSn37Kd8fARxn3JWQDut80mVW8KT
         VlMw==
Received: by 10.60.8.134 with SMTP id r6mr55424530oea.53.1358298514079; Tue,
 15 Jan 2013 17:08:34 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 15 Jan 2013 17:08:03 -0800 (PST)
In-Reply-To: <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213700>

On Wed, Jan 16, 2013 at 2:29 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:
>
>> Thank you for the explanation.
>>
>> I did not monitor the system calls when writing that patch.
>> Where is the perf framework?
>>
>> As the mistake is located in the "find_basename" function, I would p=
ropose a
>> fix directly into it so that the output fits what the other function=
s expect.
>
> Isn't that a crazy semantics for the function, though?  I would
> expect find_basename("/a/path/to/file") to return "file", not

Actually I'd like to remove that function. The function is called twice=
:

 - collect_all_attrs
   + prepare_attr_stack
     * find_basename
   + find_basename

which could be reordered to

 - collect_all_attrs
   + find_basename
   + prepare_attr_stack (modified to take dirlen from caller)

and because that'll be the only place find_basename is used, we could
just inline the code there.
--=20
Duy
