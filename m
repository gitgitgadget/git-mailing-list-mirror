From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] git-instaweb: Add support for running gitweb via 'plackup'
Date: Sun, 23 May 2010 22:21:34 +0200
Message-ID: <201005232221.36103.jnareb@gmail.com>
References: <1274290298-19245-1-git-send-email-jnareb@gmail.com> <201005192252.49461.jnareb@gmail.com> <20100523093120.GB3426@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 23 22:21:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGHgG-0001rx-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 22:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab0EWUVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 16:21:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34393 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab0EWUVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 16:21:47 -0400
Received: by bwz7 with SMTP id 7so681026bwz.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eJCaSg088kAoh2Yneay0/Kv6e6uuXf0kx7xE5ir7UuM=;
        b=Rc/V1oVj3w3VKkDblPCWywqb95a8PJNxT22gvL1CCjM4jO0/4tsOiLGKDtgwjhlHbf
         g33Q73+vTkP0obnUvZ/MADh4RjsiVtuVxME0Y/NhzT1iTtRmH06AvTdgEDisPVQw0Tea
         U6ONDzJFX1oLD7SHOl6awzJeBCgWjqdt7PED4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=epuOFnF5TApBvAjyhPSrz128y9kHTBUoH1K+dLGFNzPWhkbDZrmTjQ1ksHtjmpiq8u
         cWHQi6yndVUxIihcMqf6mrEoWY3McVnRZ7vf0VIzKxmtPnIbN2yLPcjR8VLpS7igDLiw
         M/WKuLvw458lP5hIZVyzzBhbWDc8WKoar/omA=
Received: by 10.204.128.68 with SMTP id j4mr1582722bks.49.1274646105201;
        Sun, 23 May 2010 13:21:45 -0700 (PDT)
Received: from [192.168.1.15] (abwr31.neoplus.adsl.tpnet.pl [83.8.241.31])
        by mx.google.com with ESMTPS id d13sm15644482bkd.17.2010.05.23.13.21.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 13:21:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100523093120.GB3426@dcvr.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147582>

On Sun, 23 May 2010, Eric Wong wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > Do you have any idea on how to synchronize those two processes, the web
> > server and the web client (web browser), so that web browser is run only
> > after web server prints that it is ready to accept connection?
> 
> Your polling http_is_ready() function is fine, and really the only
> portable solution across all servers (and OSes).

Well, even if we use the solution below it would be good fallback for
those web servers, for which the solution below cannot be used.

> 
> But if your webserver lets you run arbitrary code hooks after it
> binds the listen socket, what I do when writing integration tests
> is have it open a FIFO for writing.

I was thinking about 'flock' function in Perl (and similar in other
languages), and '/usr/bin/flock' utility from util-linux.  But using
FIFO as a semaphore might be a better idea: it is slighly more portable,
I guess.

Anyway, Plack handlers have (undocumented!) 'server_ready' option to web
servers, containing callback (code reference).  It can be set via
parse_options method of Plack::Runner, for example.  It is used by
'plackup' to print

  $server: Accepting connections at $proto://$host:$port

in the (default) "development" mode.

> 
> Adapted and abridged from the Rainbows! web server test suite, the
> following config snippet is from the config file for the Rainbows! web
> server:
> ---------------- rainbows.conf.rb -----------------
> after_fork do |server, worker|
>   # test script will block while reading from the FIFO,
>   # so notify the script on the first worker we spawn
>   # by opening the FIFO
>   if worker.nr == 0
>     File.open("/path/to/fifo", "wb") { |fp| fp.syswrite "START" }
>   end
> end
> ---------------------------------------------------
> 
> And then in the test script:
> ----------- my-integration-test.sh ----------------
> set -e
> mkfifo /path/to/fifo
> # start the server
> rainbows --daemonize --config-file rainbows.conf.rb
> 
> # "cat /path/to/fifo" will block until the after_fork hook is called
> # in rainbows.conf.rb
> test xSTART = x"$(cat /path/to/fifo)"
> 
> # server is up, run the rest of the tests...
> ---------------------------------------------------

I wonder how portable is that technique...

It certainly could be done in gitweb.psgi; the question is if it is it
worth it...

-- 
Jakub Narebski
Poland
