From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] On watchman support
Date: Fri, 28 Nov 2014 18:13:24 +0700
Message-ID: <CACsJy8DayFy83JijrkgST5rAbNsst-dgqaP-ebpWXoGKPtp7sA@mail.gmail.com>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
 <CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com> <1416334360.27401.10.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 12:14:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuJUv-0001BV-UT
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 12:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaK1LN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 06:13:57 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61764 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbaK1LN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 06:13:56 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so5841773iec.22
        for <git@vger.kernel.org>; Fri, 28 Nov 2014 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/qLUE3aNmHmBXVC7MC2BbDNSl093z8BwLy6SBWRV10w=;
        b=XXkB2t6O5yFtePZAHZ6CGk6xToi00g+HSBmDz0+LgIdw1WchUuCn9kICD1WPK0Uwdm
         hKZ/9pigelCs4iE5UcbsiczSTvZPx9GG0BzzKAt354zwHoHuy9LbApdC8holnltY6D0k
         eO1oSNaQEFtM8nv8+qh5bzCHS0WmXFQaUJMbWTTGu662YjEDOxf5myCYO3xAJvFvUfZj
         H4dloPkVOQ1BYDOMiXAoT1DNG6Hctwt9NTtLTU1JDp3AF6w2OF1CWfJ+KpZ8eo4v+v9l
         TfTHlr10B55vKHI4GWXlXkmvw4djaLLUuiLYhT9ZGKN1yYiue9MC5KyuAI7laZpNIMMB
         ChqQ==
X-Received: by 10.107.3.157 with SMTP id e29mr40175982ioi.44.1417173235141;
 Fri, 28 Nov 2014 03:13:55 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Fri, 28 Nov 2014 03:13:24 -0800 (PST)
In-Reply-To: <1416334360.27401.10.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260360>

On Wed, Nov 19, 2014 at 1:12 AM, David Turner <dturner@twopensource.com> wrote:
>> Or will you go
>> with cityhash now.. I ask because you have another sse optimization
>> for hashmap on your watchman branch and that could reduce init time
>> for name-hash. Name-hash is used often on case-insensitive fs (less
>> often on case-sensitive fs).
>
> Cityhash would be better, because it has actual engineering effort put
> into it; what I did on my branch is a hack that happens to work
> decently.  As the comment notes, I did not spend much effort on tuning
> my implementation.  Also, Cityhash doesn't require SSE, so it's more
> portable.

Cityhash looks less appealing to me. For one thing it's C++ so linking
to C can't be done. I could add a few "extern "C"" to make it work.
But if we plan to support it eventually, cityhash must support C out
of the box.

Then cityhash does not support case-insensitive hashing. I had to make
a CityHash32i version based on CityHash32. It's probably my bugs
there, but performance is worse (~120ms) than original hashmap.c
(90ms). Enabling sse4.2 helps a bit, but still worse. Using the
case-sensitive version in place for memihash and strihash does make
cityhash win over hashmap.c, around 50ms (with or without sse4.2). But
that's still not as good as your version (~35ms)..
-- 
Duy
