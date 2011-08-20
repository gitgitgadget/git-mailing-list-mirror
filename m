From: Chris Packham <judge.packham@gmail.com>
Subject: Re: How to use .gitattributes to tell git that .ini is text file?
Date: Sat, 20 Aug 2011 21:59:26 +1200
Message-ID: <4E4F857E.9030907@gmail.com>
References: <bfe44ee.e467.131e4f0b471.Coremail.sinojelly@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?IkdpdOiuqOiuuue7hCjml6DpobvorqLpmIUpIg==?= 
	<git@vger.kernel.org>
To: jelly <sinojelly@163.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 12:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuiQl-00014Z-Kq
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 12:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab1HTJ7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 05:59:21 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51792 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab1HTJ7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 05:59:20 -0400
Received: by pzk37 with SMTP id 37so6145009pzk.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1bGxdFgbdPH+hf8c1VzBNBjwmQGWoQ4FlqT0vwdsH3A=;
        b=WxqtI1zcxtVSaEeHwDH0TG6zMYT+Rw8e3SYjqPf7Y5uAMhGyRJsjJ0zV+VyxWiepay
         5a6WxRc0b96aqq9m0O5K2H//AMczs6I1D3HezStHI3gSuXTuzxWmefiJvhN9Vc6yJyo8
         QXpjfZI7dOKThdUZXloL97EYJeX/X4EiisXW0=
Received: by 10.142.139.3 with SMTP id m3mr270218wfd.140.1313834359640;
        Sat, 20 Aug 2011 02:59:19 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id l15sm1890131wfe.12.2011.08.20.02.59.17
        (version=SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 02:59:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <bfe44ee.e467.131e4f0b471.Coremail.sinojelly@163.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179757>

On 20/08/11 14:06, jelly wrote:
> When I use like this, it takes no effect.
> C:\Users\jelly\Documents\My Knowledge\Plugins>cat .gitattributes*.ini     text
> C:\Users\jelly\Documents\My Knowledge\Plugins>git diffdiff --git a/Misc/plugin.ini b/Misc/plugin.iniindex 078c8a9..f73153c 100755Binary files a/Misc/plugin.ini and b/Misc/plugin.ini differ

I think you might be running into some problems with the end of line
detection. What git version are you running? I think what you want in
.gitattributes is '*.ini diff' (see below)

I did some quick tests with 1.7.5 and I seem to get sane behaviour
without needing .gitattributes

  printf '\r\nfoo\r\n' > foo.ini
  git commit -m"" foo.ini

  # change content
  printf '\r\nbar\r\n' > foo.ini
  git diff
  diff --git a/foo.ini b/foo.ini
  index 35c61a9..b2b98e6 100644
  --- a/foo.ini
  +++ b/foo.ini
  @@ -1,2 +1,2 @@

  -foo
  +bar

  # insert non-printable character
  printf '\nbar\0\n' > foo.ini
  git diff
  diff --git a/foo.ini b/foo.ini
  index 35c61a9..aff5caf 100644
  Binary files a/foo.ini and b/foo.ini differ

Even with the binary content I can tell git diff to treat the files as
text (not that you can see it in the email but with less as my pager I
actually get an indication that there is a funny character there)

  git diff -a
  diff --git a/foo.ini b/foo.ini
  index 35c61a9..aff5caf 100644
  --- a/foo.ini
  +++ b/foo.ini
  @@ -1,2 +1,2 @@
  -
  -foo
  +
  +bar

If you want to tell git diff to always use the -a option for .ini files
try this

  echo '*.ini diff' > .gitattributes
  git diff
  diff --git a/foo.ini b/foo.ini
  index 35c61a9..aff5caf 100644
  --- a/foo.ini
  +++ b/foo.ini
  @@ -1,2 +1,2 @@
  -
  -foo
  +
  +bar
