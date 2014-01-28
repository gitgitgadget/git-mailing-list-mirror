From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] Added get sendmail from .mailrc
Date: Mon, 27 Jan 2014 22:19:22 -0800
Message-ID: <1B2852B7-5CDB-4C8E-AF0D-5375DB95A4AB@gmail.com>
References: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru> <20140128011512.GB17945@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 28 07:19:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W821F-0000Qc-1P
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 07:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbaA1GT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 01:19:26 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:52932 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaA1GTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 01:19:25 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so6575917pdj.8
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 22:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=nb4R5HoK9WOyNkzf6Bs8o++Zyf7wUlz+wphbookh+VM=;
        b=Q3sWnAwHy1gIjczCNb6yot4Mx6q0yACakSivs6iEY7U1AWwfaE6UiNUn6IBklduuyQ
         DPhD0oj4maX4696DO62KplixX6WkvbLbFWI5gbMvTo+KslH2fLY9iX0w+P8xDmvHuX+B
         nxzetBJoSQiDlkFebZ80FL1T+8bfzVt14oA/FZi9musC/Z2C4ozLIVece5fbEKzuvfGs
         Irbf/5HDZJoQdzeovdeMg68YiZvtbHZFGnecy2zWLiJq1zZmWM8ipkGiJAc36YxQ6c7o
         pO74AHtWrbai7eozuZBhUdybODaFPo3b1I9gREDPLDGIK8SL+0lrifiSI/hyexkl+bp7
         L6iw==
X-Received: by 10.68.130.234 with SMTP id oh10mr7829221pbb.136.1390889965353;
        Mon, 27 Jan 2014 22:19:25 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id de3sm38395545pbb.33.2014.01.27.22.19.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 22:19:24 -0800 (PST)
In-Reply-To: <20140128011512.GB17945@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241180>

On Jan 27, 2014, at 17:15, Jeff King wrote:
> On Sat, Jan 25, 2014 at 01:46:50PM +0400, Brilliantov Kirill  
> Vladimirovich wrote:
>
>> +	if (!defined $smtp_server) {
>> +		my $mailrc = File::HomeDir->my_home . "/.mailrc";

Actually, based on the output of "man mail", this should probably be  
something more like

   my $mailrc = $ENV{'MAILRC'} || "$ENV{'HOME'}/.mailrc";

which takes into account any MAILRC setting and also avoids the use of  
File::HomeDir.

>> +			while (<FILE>) {
>> +			    chomp;
>> +			    if (/set sendmail=.*/) {
>> +				my @data = split '"';
>> +				$smtp_server = $data[1];
>> +				last;
>> +			    }
>
> Your split is a rather unusual way to do the parsing, and it took me a
> minute to figure it out. It might be more obvious as:
>
>  if (/set sendmail="(.*)"/) {
>          $smtp_server = $1;
>          last;
>  }
>
> I do not know anything about the mailrc format, nor does it seem to be
> well documented. Are the double-quotes required? If not, then the  
> above
> regex can easily make them optional. I also wonder if any whitespace  
> is
> allowed.

 From "man mail":

    set   (se) With no arguments, prints all variable values.   
Otherwise,
          sets option.  Arguments are of the form option=value (no space
          before or after `=') or option.  Quotation marks may be placed
          around any part of the assignment statement to quote blanks or
          tabs, i.e. ``set indentprefix="->"''

My version of "man mail" does not list all the variables that can be  
set but it refers to "The Mail Reference Manual" document which  
presumably does.  I did find this [1] that documents many of the  
available variables including the sendmail one.  I then tried this:

cat <<EOF > /tmp/shim
#!/bin/sh
exec cat
EOF
chmod a+x /tmp/shim
cat <<EOF > /tmp/testrc
   se   send"mail"=/tm"p/"shim
EOF
echo 'testing' | MAILRC=/tmp/testrc mail -s test nobody

And to my surprise the contents of the new message were cat'd out to  
the terminal rather than being sent.  So clearly there's some room for  
improvement with the "set", white space and quote checking.

[1] http://www.cs.fsu.edu/sysinfo/mail/mailrc.html

--Kyle
