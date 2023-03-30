Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53EAC77B62
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 08:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjC3IAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 04:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjC3IAo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 04:00:44 -0400
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 01:00:42 PDT
Received: from blade-b3-vm-relay.servers.aueb.gr (blade-b3-vm-relay.servers.aueb.gr [195.251.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11E8718F
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 01:00:41 -0700 (PDT)
Received: from blade-a1-vm-smtp.servers.aueb.gr (blade-a1-vm-smtp.servers.aueb.gr [195.251.255.217])
        by blade-b3-vm-relay.servers.aueb.gr (Postfix) with ESMTP id 96ED02790;
        Thu, 30 Mar 2023 10:55:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aueb.gr; s=201901;
        t=1680162901; bh=6udhiO8UV+8jwQvzo90qxeb6fF07aRLhQAY7eCYXSTo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cqj8j0uw6ZVuCkSwxaX+vde2w+qV362pw5Clomz8gS6MOfKII6TJUATZXa4tok85O
         Amsy3CAzCXO1HVmYXWtIgXnOYLrIRnVAOXk+XnkTKbXWToEcs1rZCvI7K1d5CbAC1D
         efijYCl22Ru2cgpxLX5vaGlg3zsOt9ldL6fdgKkJi8sO0oniOtVUOIY9IJoK7sHKbS
         aNd0FxkeI9IecjmJB8ibKN+a2z6JnHg2XgoOgWgSVBVxPZwokcf8GHI6r62WgKEEpS
         tCDevcGEiFZmLZij7gUb8nVCpm2EZEsKCycAn7aLOn4TQFrevm/tVO6xuv3QYREJqe
         XqXz1kBmE7Y8A==
Received: from [192.168.136.3] (ppp-94-69-179-198.home.otenet.gr [94.69.179.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dds)
        by blade-a1-vm-smtp.servers.aueb.gr (Postfix) with ESMTPSA id ECD6B66;
        Thu, 30 Mar 2023 10:55:00 +0300 (EEST)
Message-ID: <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
Date:   Thu, 30 Mar 2023 10:55:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: regex compilation error with --color-words
Content-Language: el-en
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
From:   Diomidis Spinellis <dds@aueb.gr>
Organization: Athens University of Economics and Business
Phone:  +30 210 8203621
In-Reply-To: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30-Mar-23 1:55, Eric Sunshine wrote:
> I'm encountering a failure on macOS High Sierra 10.13.6 when using
> --color-words:

The built-in word separation regular expression pattern for the Perl 
language fails to work with the macOS regex engine.  The same also 
happens with the FreeBSD one (tested on 14.0).

The issue can be replicated through the following sequence of commands.

git init color-words
cd color-words
echo '*.pl   diff=perl' >.gitattributes
echo 'print 42;' >t.pl
git add t.pl
git commit -am Add
git show --color-words

Strangely, I haven't been able to reproduce the failure with egrep on 
any of the two platforms.

egrep 
'[[:alpha:]_'\''][[:alnum:]_'\'']*|0[xb]?[0-9a-fA-F_]*|[0-9a-fA-F_]+(\.[0-9a-fA-F_]+)?([eE][-+]?[0-9_]+)?|=>|-[rwxoRWXOezsfdlpSugkbctTBMAC>]|~~|::|&&=|\|\|=|//=|\*\*=|&&|\|\||//|\+\+|--|\*\*|\.\.\.?|[-+*/%.^&<>=!|]=|=~|!~|<<|<>|<=>|>>|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+' 
/dev/null
