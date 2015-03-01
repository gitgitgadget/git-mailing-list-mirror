From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 2/5] upload-pack: support out of band client
 capability requests
Date: Sun, 1 Mar 2015 07:11:49 +0700
Message-ID: <CACsJy8A2bMgTr4cg73dV_JPr3U_5PiLCr9iRGpK79sg3QR39dg@mail.gmail.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com> <1425085318-30537-3-git-send-email-sbeller@google.com>
 <AB630BA1-8D48-418D-B576-6495DBE67C52@gmail.com> <CACsJy8DA86yBoYxvEbgUzoxGOwsKw0mO50iQ0qvNrxaihRNe2g@mail.gmail.com>
 <BA483DD3-3AD5-4B52-8379-F9FBA9A9305E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 01:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRrY6-000398-Hy
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 01:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbbCAAMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 19:12:21 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:45422 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbCAAMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 19:12:20 -0500
Received: by igjz20 with SMTP id z20so9115704igj.4
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 16:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oHoshgA+W0L0ESM5nH6ZU/QbR6doHN5hnzcOnSqsCkY=;
        b=o/JpIRMFgLZcEfv5dmtnwuo2Pjl54B3fy2GKmD5v6RDBjC23luLlfi2ACa6APDgAUc
         tQtAPb50jiAV02siuyX8SjU8cGQJxSKz8ytpMKcTH03rjTJlDxIEfH8rFL+0blxax3g6
         V+3NZulPmZNxXk5gi2vS8Y7KMmjVXUC29jVmpNqAxeRAfunG16YLcNIElPEhhFrf2E4s
         /qA5xRpaV1EZLMI6YkpFdxjRslWnhGkqYdfuHuGK97b+fV5J/RurjsFhViE7uzc68cvR
         DvHmrZ8q3dg1s81crA0qAowIAw/YcqQuejoul8amgypWd5VXbMuAPiM6ndDjkwsLvBMy
         iJLg==
X-Received: by 10.50.118.97 with SMTP id kl1mr13403982igb.23.1425168739561;
 Sat, 28 Feb 2015 16:12:19 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Sat, 28 Feb 2015 16:11:49 -0800 (PST)
In-Reply-To: <BA483DD3-3AD5-4B52-8379-F9FBA9A9305E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264539>

On Sun, Mar 1, 2015 at 5:36 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
>
> On Feb 28, 2015, at 03:22, Duy Nguyen wrote:
>>
>> The client should only trigger this behavior when it knows the server
>> can deal with it. And that is possible because in the last fetch, the
>> server has told the client that it's capable of receiving this
>> capabilities argument. Backward compatibility is a concern at client
>> side, not server side.
>>
>>> I've looked at those links and it's unclear to me how they support an
>>> out-of-band option for ssh, they seem to be targeted at git-daemon.
>>> Maybe
>>> there's another reference?
>>
>>
>> For ssh, I think connect.c is the one that constructs and executes ssh
>> command.
>
>
> This I assume you're referring to this change in connect.c from [1]:
>
> @@ -729,6 +734,8 @@ struct child_process *git_connect(int fd[2], const char
> *url,
>                         conn->use_shell = 1;
>                 }
>                 argv_array_push(&argv, cmd.buf);
> +               if (service_flags)
> +                       argv_array_push(&argv, service_flags);
>                 conn->argv = argv.argv;
>                 if (start_command(conn))
>                         die("unable to fork");
>
> That's not going to work for ssh servers running a stock git-shell and I
> haven't seen any updates to shell.c to match.  git-shell does not allow
> anything other than one argument to be passed to
> git-upload-pack/git-receive-pack.
>
> When shell.c calls do_generic_cmd and it calls sq_dequote on its argument
> that contains "'dir' 'service-flags'" it's going to return NULL and shell.c
> will die("bad argument").  So I don't see how this supports ssh as-is even
> if you know in advance the server supports the new protocol.  I don't see
> any changes to shell.c in that uploadpack2 branch nor in this patch series.

You're right. If we continue to pass client capabilities as an extra
argument, then git-shell needs updates.
-- 
Duy
