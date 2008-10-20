From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 5/5] gitweb: generate parent..current URLs
Date: Mon, 20 Oct 2008 16:57:44 +0200
Message-ID: <cb7bb73a0810200757h540a699qd9d3ea236fc7b5ad@mail.gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1224188831-17767-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810201249.14426.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 20:14:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrwDj-0004iu-IE
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbYJTO5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 10:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbYJTO5q
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 10:57:46 -0400
Received: from el-out-1112.google.com ([209.85.162.180]:38042 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYJTO5q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 10:57:46 -0400
Received: by el-out-1112.google.com with SMTP id z25so392265ele.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tqnYf6/aORttgJHzgvGk8NxwHg/JhBtqPTNDRucoO/I=;
        b=cNOxBcgtO5Tnceze204fFidDBdMvQL/PBbUuUFGcQqBu8Ge1fwqiqS8QFN54wgw3Mp
         0zTIyG/Avh6HlFgMsq6phxR033oDU1QqPrF2cpaSulZa7evWsk7CEuL8SFd1vxaiWItp
         xH5xLOKVP+1zWrP0OEtGQx++YV8cu7qUibCYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=q9BLL4uuTb7qTyijIyPzrFol43AS6ETB8El/AghONe4neWQwE+d1QxMxrlJRyoSgi2
         5LvkoCXSTQmZ9A6NZ1TS9g1KQUQkvy3IiuTwbgBEnZMaq17sVrLPzGLzZUD484C5WmaG
         THaJS6FgC/c9kQl2WAPyld+MB/7Y5vc3WiTJ4=
Received: by 10.151.155.5 with SMTP id h5mr12417507ybo.49.1224514664778;
        Mon, 20 Oct 2008 07:57:44 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Mon, 20 Oct 2008 07:57:44 -0700 (PDT)
In-Reply-To: <200810201249.14426.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98686>

On Mon, Oct 20, 2008 at 12:49 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> -             #   - hash or hash_base:/filename
>> +             #   - hash_parent or hash_parent_base:/file_parent
>> +             #   - hash or hash_base:/file_name
>
> Minor nit: this contain independent change 'filename' -> 'file_name',
> but I think it is not worth separating...

Oopsie. Oh well, I was getting so used to all those _  that it felt
strange without

>>               # When the script is the root DirectoryIndex for the domain,
>>               # $href here would be something like http://gitweb.example.com/
>> @@ -778,17 +779,36 @@ sub href (%) {
>>                       delete $params{'action'};
>>               }
>>
>> -             # Finally, we put either hash_base:/file_name or hash
>> +             # Next, we put hash_parent_base:/file_parent..hash_base:/file_name,
>> +             # stripping nonexistent or useless pieces
>> +             $href .= "/" if ($params{'hash_base'} || $params{'hash_parent_base'}
>> +                     || $params{'hash_parent'} || $params{'hash'});
>
> Nice trick (and required change).
>
>>               if (defined $params{'hash_base'}) {
>> -                     $href .= "/".esc_url($params{'hash_base'});
>> -                     if (defined $params{'file_name'}) {
>> +                     if (defined $params{'hash_parent_base'}) {
>> +                             $href .= esc_url($params{'hash_parent_base'});
>> +                             # skip the file_parent if it's the same as the file_name
>> +                             delete $params{'file_parent'} if $params{'file_parent'} eq $params{'file_name'};
>> +                             if (defined $params{'file_parent'} && $params{'file_parent'} !~ /\.\./) {
>> +                                     $href .= ":/".esc_url($params{'file_parent'});
>> +                                     delete $params{'file_parent'};
>> +                             }
>
> Side note: I wonder if we should use esc_url or esc_param here...

esc_url, I would say, allowing us to build RFC-compliant URLs. Isn't
esc_param for CGI?


-- 
Giuseppe "Oblomov" Bilotta
