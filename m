From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [RFC/PATCH 2/5] upload-pack: support out of band client capability requests
Date: Sat, 28 Feb 2015 14:36:18 -0800
Message-ID: <BA483DD3-3AD5-4B52-8379-F9FBA9A9305E@gmail.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com> <1425085318-30537-1-git-send-email-sbeller@google.com> <1425085318-30537-3-git-send-email-sbeller@google.com> <AB630BA1-8D48-418D-B576-6495DBE67C52@gmail.com> <CACsJy8DA86yBoYxvEbgUzoxGOwsKw0mO50iQ0qvNrxaihRNe2g@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 23:36:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRpzp-0003Vn-4L
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 23:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbbB1WgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 17:36:23 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38998 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbB1WgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 17:36:22 -0500
Received: by pdjy10 with SMTP id y10so29681804pdj.6
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 14:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=LbzZECU9nTRYdsUpzZfNJKl5NbS84ccrOGnMNHVKShA=;
        b=FDkyoDAh19AgpWQA7X0FcG7slpISUe1uO8EjH2+Kx352Yzr8/BkiHbM3T7lC9OvzaF
         7nUj+1aAHObIp6rUXF36905M9W/RTi/enwiCp390C07UgqG6QdXBiLF/Cj3W452fzD2g
         5vbs/TNH9MfI3VnUrVfWTodgob5a1nYFLYwV1zE44L+0RWXW5If5IQY4l6qthiFKiNf9
         HvPH7MiQEBfa1+l+wPKm/94gNLR7QL4rPO/99jZ2sjyxk43R3y0J/AkAWl5Jg+hX5cam
         aTHplL7j1xtnKI0vCLU39FAxQBkoLRcoLwo+DTkxXkzAKo1cktuW3p7ArD4bua+vSA0t
         3AdQ==
X-Received: by 10.70.127.166 with SMTP id nh6mr2516736pdb.159.1425162981948;
        Sat, 28 Feb 2015 14:36:21 -0800 (PST)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id oq4sm7676390pdb.73.2015.02.28.14.36.20
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 28 Feb 2015 14:36:21 -0800 (PST)
In-Reply-To: <CACsJy8DA86yBoYxvEbgUzoxGOwsKw0mO50iQ0qvNrxaihRNe2g@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264538>


On Feb 28, 2015, at 03:22, Duy Nguyen wrote:
> The client should only trigger this behavior when it knows the server
> can deal with it. And that is possible because in the last fetch, the
> server has told the client that it's capable of receiving this
> capabilities argument. Backward compatibility is a concern at client
> side, not server side.
>
>> I've looked at those links and it's unclear to me how they support an
>> out-of-band option for ssh, they seem to be targeted at git- 
>> daemon.  Maybe
>> there's another reference?
>
> For ssh, I think connect.c is the one that constructs and executes  
> ssh command.

This I assume you're referring to this change in connect.c from [1]:

@@ -729,6 +734,8 @@ struct child_process *git_connect(int fd[2], const  
char *url,
                         conn->use_shell = 1;
                 }
                 argv_array_push(&argv, cmd.buf);
+               if (service_flags)
+                       argv_array_push(&argv, service_flags);
                 conn->argv = argv.argv;
                 if (start_command(conn))
                         die("unable to fork");

That's not going to work for ssh servers running a stock git-shell and  
I haven't seen any updates to shell.c to match.  git-shell does not  
allow anything other than one argument to be passed to git-upload-pack/ 
git-receive-pack.

When shell.c calls do_generic_cmd and it calls sq_dequote on its  
argument that contains "'dir' 'service-flags'" it's going to return  
NULL and shell.c will die("bad argument").  So I don't see how this  
supports ssh as-is even if you know in advance the server supports the  
new protocol.  I don't see any changes to shell.c in that uploadpack2  
branch nor in this patch series.

-Kyle

[1] https://github.com/pclouds/git/commit/20d048e5fc650b20fdc7dd8bbe35cb8510ac9c50
