From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 12:35:09 -0500
Message-ID: <CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
	<7vfvym30t8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFDc-0006dW-Vm
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab3DSRfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:35:17 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:42032 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab3DSRfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:35:15 -0400
Received: by mail-lb0-f172.google.com with SMTP id u10so3974067lbi.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RE0SJzMe0kzs+oMNXF81srZzZqr8lzgEXTgAdViecWM=;
        b=NooD/QZxBbd2ktSQTS//Hi0jDmZ3uTDU2hyfjZHk+Fc94snOKp29znz9mCSWbuhiKV
         31TqHSYZByptZDTtRNb9h6/ChWvWlmU88ecis6bjLuIgNmOYXvx5b29aNYW+avFZ9tu0
         ofJHX78ym/fKopBtOAAIlgmZJFfoSPwB9eG2hRjZXtvS5emj5EXoqvPKd9W9eZ1gYz4B
         WLKFoJFBbV3MBv6nfTWn9YYfiiYC5ZIkn4QVYnCNlR7iK7nS6RY73B3gQy1o+UXsu7gs
         RLPAkVFup3WQTwvYQnvoHj14eQkjvbDlmn5lNbhMUxgpJEeOwcdmeFW+xWQcgwH9ZcYd
         JZpg==
X-Received: by 10.112.139.226 with SMTP id rb2mr7579051lbb.12.1366392909868;
 Fri, 19 Apr 2013 10:35:09 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 19 Apr 2013 10:35:09 -0700 (PDT)
In-Reply-To: <7vfvym30t8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221783>

On Fri, Apr 19, 2013 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> The code finds the changes of a commit, runs 'git blame' for each chunk
>> to see which other commits are relevant, and then reports the author and
>> signers.
>
> In general, I am not all that interested in adding anything new to
> contrib/ as git.git has matured enough, but even if this will stay
> outside my tree, there are a few interesting things to note to help
> its eventual users.

Why not add it to mainline git then? This tool, or a similar one,
would certainly be useful in the git arsenal.

>> +    roles = roles.map do |person, role|
>> +      address = "%s <%s>" % person
>> +      [person, role]
>> +    end
>
> Is address being used elsewhere, or is this a remnant from an
> earlier debugging or something?

It's used later on; it creeped in.

>> +    [id, roles]
>> +  end
>> +
>> +end
>> ...
>> +    File.open(file) do |f|
>> +      f.each do |line|
>> +        case line
>> +        when /^From (\h+) (.+)$/
>> +          from = $1
>> +        when /^---\s+(\S+)/
>> +          source = $1 != '/dev/null' ? $1[2..-1] : nil
>
> This may need to be tightened if you want to use this on a
> real-world project (git.git itself does not count ;-); you may see
> something like:
>
>     diff --git "a/a\"b" "b/a\"b"
>
> (I did an insane pathname 'a"b' to get the above example, but a more
> realistic is a character outside ASCII).

Suggestions on how to do that are welcome.

>> +        when /^@@\s-(\d+),(\d+)/
>> +          get_blame(source, $1, $2, from)
>
> This may want to be a bit more careful for a hunk that adds to an
> empty file, which will give you something like
>
>     @@ -0,0 +1 @@
>     @@ -0,0 +1,200 @@

Simple:
return unless source and start and offset

> Nobody sane would use -U0 when doing a format-patch, but if this
> wants to accomodate such a patch as well, it needs to ignore a hunk
> that only adds new lines.

I'm not going to worry about it now.

Cheers.

-- 
Felipe Contreras
