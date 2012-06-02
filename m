From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4] Read (but not write) from XDG configuration, XDG attributes and XDG ignore files
Date: Sat, 02 Jun 2012 23:05:55 +0200
Message-ID: <vpqtxyt4e6k.fsf@bauges.imag.fr>
References: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<vpq7gvq9czb.fsf@bauges.imag.fr>
	<20120602175209.Horde.QpN5M3wdC4BPyjaps7w1bMA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sat Jun 02 23:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SavX1-0000Su-SC
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 23:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183Ab2FBVGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 17:06:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33830 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932536Ab2FBVGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 17:06:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q52KvTlj031108
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 2 Jun 2012 22:57:29 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SavWG-0000OB-S8; Sat, 02 Jun 2012 23:05:56 +0200
In-Reply-To: <20120602175209.Horde.QpN5M3wdC4BPyjaps7w1bMA@webmail.minatec.grenoble-inp.fr>
	(nguyenhu@minatec.inpg.fr's message of "Sat, 02 Jun 2012 17:52:09
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 02 Jun 2012 22:57:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q52KvTlj031108
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339275453.37246@OPczEoZxXXJyFcx2oCmRgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199060>

nguyenhu@minatec.inpg.fr writes:

>>> --- a/dir.c
>>> +++ b/dir.c
>>> @@ -1234,13 +1234,17 @@ int remove_dir_recursively(struct strbuf  
>>> *path, int flag)
>>>  void setup_standard_excludes(struct dir_struct *dir)
>>>  {
>>>  	const char *path;
>>> +	char *xdg_path;
>>>
>>>  	dir->exclude_per_dir = ".gitignore";
>>>  	path = git_path("info/exclude");
>>> +	home_config_paths(NULL, &xdg_path, "ignore");
>>>  	if (!access(path, R_OK))
>>>  		add_excludes_from_file(dir, path);
>>>  	if (excludes_file && !access(excludes_file, R_OK))
>>>  		add_excludes_from_file(dir, excludes_file);
>>> +	else if (!access(xdg_path, R_OK))
>>> +		add_excludes_from_file(dir, xdg_path);
>>>  }
>> Same remark here. Look at the patch I sent earlier to give a default
>> value:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/133343/focus=133415
>>
>> For example, you version reads from XDG file if core.excludesfile is
>> set, but the file it points to doesn't exist. I don't think this is
>> expected.
>
> Actually, it's the opposite. Our version only read from XDG file if  
> core.excludesfile is not set.

It's what you want to do, but not what I read from the code. Your "else
if" above is reachable if "excludes_file && !access(excludes_file, R_OK)"
is false, which includes the case when excludes_file is set but does not
exist.

Anyway, this just shows that the logic is too complex, we shouldn't need
this discussion with simple enough code.

> echo $HOME and echo "$HOME"
>       both returns /.../t/trash directory.t1306-read-xdg-config-file
> but   echo foo >$HOME   writes in ../t/trash
> while echo foo >"$HOME" writes in t/trash directory.t1306-read-xdg-config-file
> so "$HOME" is needed for the tests to work.

In general, $HOME means "evaluate $HOME and do the whitespace splitting
after", and "$HOME" means "evaluate $HOME and don't do whitespace
splitting". Since "trash directory" contains a space, you need the
quoting.

There are places where quoting is not needed, though, and I think
redirect is part of them. But I wouldn't be surprised if the different
levels of quoting when ran in test-lib broke that.

My advice: always quote variables, unless you have a very good reason
not to do so.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
