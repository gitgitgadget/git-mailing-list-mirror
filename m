From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 14:09:55 -0500
Message-ID: <53726e0355875_4aa4b312f892@nysa.notmuch>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
 <53711AA5.4040001@web.de>
 <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
 <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
 <537233CC.3050904@web.de>
 <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
 <20140513184800.GF9051@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: William Giokas <1007380@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 21:21:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkIG5-0008RX-8g
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 21:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbaEMTU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 15:20:58 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:43536 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbaEMTU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 15:20:56 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so947485obc.31
        for <git@vger.kernel.org>; Tue, 13 May 2014 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ilS63Fve+fTLlR8v5McU71iqzOBvL0s8+HErOHjwkjs=;
        b=N9hWFz5gXkRqQIMOXWLvvu3d8JSeW6MWuhfY8KBdVSyeMsMJvARpyjsl9MgjEfZWe5
         UQ1ndE0Hm3lO4m9N/1kHAE4gETjmLvocE5MoXOKCjmje6MJL8Vv6lbxvi8Otwjq9ItB3
         O/QqFBg41bfbws6gJcC/ZWcfBhWDfQ3nCFXQuo0vJk2RNSnO3QB1OEMVHHzl5oOAYu1U
         5UT1yWJ7dfeke4iAvmCtUaDRiu4SFXdUXYRa5e3Jj/M+n8OYjNhXJAA1upe4TCyauQei
         PPqHtqGPw1xEK51bcZ7d0Dc12Jiz2z4WSt3gwXghV6kQf1mb7Xo2LXG0on5+0skAjmvW
         HOZg==
X-Received: by 10.60.51.136 with SMTP id k8mr1277974oeo.33.1400008856407;
        Tue, 13 May 2014 12:20:56 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jy6sm27513477obc.25.2014.05.13.12.20.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 12:20:50 -0700 (PDT)
In-Reply-To: <20140513184800.GF9051@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248807>

William Giokas wrote:
> On Tue, May 13, 2014 at 10:30:26AM -0700, Junio C Hamano wrote:

> >     Why do we "import changegroup" unconditionally, even though it
> >     is only used in the new codepath meant only for version 3.0 or
> >     higher, not inside the "if" block that decides if we need that
> >     module? 

> changegroup is prefectly /okay/ to import unconditionally, though as you
> say it will never be used.

As you say, it's perfectly OK.

> We can also be even more explicit with what we import by doing something
> like::
> 
>   try:
>       from mercurial.changegroup import getbundle
> 
>   except ImportError:
>       def getbundle(__empty__, **kwargs):
>           return repo.getbundle(**kwargs)

We could try that, but that would assume we want to maintain getbundle()
for the long run, and I personally don't want to do that. I would rather
contact the Mercurial developers about ways in which the push() method
can be improved so we don't need to have our own version. Hopefully
after it's improved we wouldn't have to call getbundle().

Moreover, eventually there will be a Mercurial 4.0, even 5.0, and at
some point we would want to remove the hacks for older versions. When we
do so we would want the import to remain unconditionally, and remove the
'check_version(3, 0)' which is already helping to explain what the code
is for without the need of comments.

> I was really sad to see that, and didn't have time to really look at it
> because of work and other projects, but I hope this presents a better
> solution than the current patch.

Either way Junio doesn't maintain this code, I do. And it's not
maintained in git.git, git's maintained out-of-tree (thanks to Junio's
decisions).

So please post your suggestions and patches to git-fc@googlegroups.com,
and use the latest code at https://github.com/felipec/git-remote-hg.

Cheers.

-- 
Felipe Contreras
