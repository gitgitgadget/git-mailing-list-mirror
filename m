From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Fri, 21 Mar 2014 19:40:19 +0100
Message-ID: <532C8793.8050202@gmail.com>
References: <20140319213556.2FC3D4062B@wince.sfo.corp.google.com> <CACsJy8D01gxeSoxgD9QkLgS85B=Af8aXytuqn6CBkF+_7WjZtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Duy Nguyen <pclouds@gmail.com>, Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:40:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4Mi-0004Mf-IY
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbaCUSkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:40:20 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:53370 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaCUSkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:40:19 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so2112994eek.26
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=AaJ4mityDX12riIbjsoY8uPgsRbumVRhC87QwASgGZY=;
        b=rzV6nnnZ57UkM4JVrMsdD4Q5PZYdxhclaC5ncWDi1gia2J2WvO6jyH9tIq0I6zdhqC
         cSfsvA/Nn7nX/3Qq2JacuQAMptMfPp1PsHmDHGHP1uZDLgbvZb/EuwW8uVbr/ePJrHbc
         aMPhPuyuld30Mq6MDg+uBAK8RvbQFtojaEn7l0XIswozratV7UFNvCfUnLM1fdiR3XUR
         Kg6EJ4eJZ8gncZ2WC0wfRCuvXsFZHoBxNcU5TiHLALL6E/IWkkFeS/zTrdu4/QGD6S0B
         iz5+1gacjByeWGNuJtBZxokR2m4m51L/glYJvZnri65YtW/2cDOpdFequ5nvp/ZCqq/k
         ZK3g==
X-Received: by 10.14.199.8 with SMTP id w8mr3822538een.94.1395427218203;
        Fri, 21 Mar 2014 11:40:18 -0700 (PDT)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w12sm13340644eez.36.2014.03.21.11.40.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 11:40:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CACsJy8D01gxeSoxgD9QkLgS85B=Af8aXytuqn6CBkF+_7WjZtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244719>

Am 20.03.2014 02:25, schrieb Duy Nguyen:
> On Thu, Mar 20, 2014 at 4:35 AM, Stefan Zager <szager@chromium.org> wrote:
>> This adds a Windows implementation of pread.  Note that it is NOT
>> safe to intersperse calls to read() and pread() on a file
>> descriptor.  According to the ReadFile spec, using the 'overlapped'
>> argument should not affect the implicit position pointer of the
>> descriptor.  Experiments have shown that this is, in fact, a lie.
>>
>> To accomodate that fact, this change also incorporates:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/196042
>>
>> ... which gives each index-pack thread its own file descriptor.
> 
> If the problem is mixing read() and pread() then perhaps it's enough to do
> 
> output_fd = dup(output_fd);
> 

Unfortunately not, dup() / DuplicateHandle() just opens another handle to the same file object (i.e. sharing the same file position).
