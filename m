From: David Turner <dturner@twopensource.com>
Subject: Re: [WIP PATCH 00/14] Protocol v2 patches
Date: Tue, 24 May 2016 18:46:48 -0400
Organization: Twitter
Message-ID: <1464130008.24478.134.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 25 00:46:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5L6F-0003Fe-S0
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 00:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcEXWqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 18:46:52 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35969 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbcEXWqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 18:46:50 -0400
Received: by mail-qk0-f174.google.com with SMTP id x7so22659457qkd.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 15:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=pdtIfjUhIMcyMIZ1Rr6uNltndnhyKSB9OHs7TkWeZbc=;
        b=wx0C9FFTSh4pbEiqkmIryooFHODdPfOzV3Zuohe8PNc5UutLLBKvftIg/MrNsXnHlp
         ddV8ar+dNWGFk+G51QQq18UdM1QHpFmRDBRYXdC+0bXzrYRXgvwV8dY3qTs+gkD4HZIP
         qctOIquPiXtp5uiPbWYSJyGHmO/g0P5iv7vykUJGo4hyK30iCkTLPX9Yyj5u9ceOsDnI
         61ZkHLAStCnqXVzs9yzSGbNzdP6AieyqmVCOLl3jyPjbo/veYJQBRqnK0C2M7C/pYV4b
         kStL6ASNq5aOHcL+NadPQgioPwgVJU/Py4buotcj/+vwUPREjMuX/+HnmwlPHcuT4pAD
         yDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pdtIfjUhIMcyMIZ1Rr6uNltndnhyKSB9OHs7TkWeZbc=;
        b=fqpK4tuCWUsanAVTHx7qzDVAExee98gpfDDxDYerTz5RAJsujJ+JVN6RXGUsVmu2ac
         xxxfXrUIo3oRITYPEsMOJnjQ93hcrOK3dCMif5wyylRAappCTxU8alxJu/kirCfWeSjh
         IgdfokK/9ik5T2q/xepvEhVUvdifLuAcFLNAbC81Z/CmG9LhSWs3qFqeGQ6qAaZrtoea
         KTUkssZgvD3bMjDg1+nLIJzmjgrgH0t7EDCGNoKEr831+lEJJ44dFFZZBeTg/vPgLUZL
         wAVdycitrbM89OflOlLshCoDBu2C9YkeubZgQdzoXirgcll7TQ/xDBHeeOO3hIR7y8SG
         D4HQ==
X-Gm-Message-State: ALyK8tK2cVrq6HU3rL/5v4JhQ4/v7OyoClmw2QBj/1/3Nms2wNr+jL6TFbE0bEhcSHfh0g==
X-Received: by 10.55.67.21 with SMTP id q21mr621528qka.49.1464130009787;
        Tue, 24 May 2016 15:46:49 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c203sm1465501qhc.41.2016.05.24.15.46.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 15:46:48 -0700 (PDT)
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295541>

I was looking at this again today, and noticed that it doesn't really
address the HTTP case.

The central problem is that protocol v2 goes like this:
server: I have capabilities w,x,y, and z
client: I want capabilities x and z.

But HTTP goes like this:
client: [request]
server: [response]

I tried to make libcurl do the receive-before-sending thing, but it
doesn't seem to be designed for it (even if you prime things by sending
a "hello" from the client first).  My thought was to hook up
CURLOPT_READFUNCTION and CURLOPT_WRITEFUNCTION, and have the read
function return CURL_READFUNC_PAUSE and then have the write (=client
receiving data ) function unpause the reader (= client sending data)
once it gets the capabilities.  But apparently pausing only works with
chunked encoding, which seems to cause Apache's mod_cgi to fail.

Maybe I'm missing something.  Has anyone else ever made something like
this work?

Of course, I could always use CURLOPT_CONNECT_ONLY to write my own HTTP
client, but that seems pretty unreasonable.

I also looked to see if libcurl had websockets support, since that's
one kind of bidirectional conversation over HTTP, but it doesn't seem
to.

Another choice is to make a separate /capabilities endpoint that gets
hit before /info/refs.  This is a bit bad because:
(a) it's another HTTP request
(b) it adds implicit state to the HTTP conversation.  If multiple git
servers were behind a load balancer, you might end up getting server A
for /capabilities and server B for /info/refs, and those servers might
have different capabilities.  This is not impossible when testing a git
server upgrade on one machine before rolling it out to a whole fleet. 
 Maybe the rule for clients re capabilities is that they can request
whatever capabilities they want, but the server is free to ignore that
request and send whatever data it feels like.  That's not great, but it
should work (I think).

Does anyone else have any thoughts on how this ought to work?
