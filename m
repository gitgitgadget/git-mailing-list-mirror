From: Stefan Beller <stefanbeller@gmail.com>
Subject: scan.coverity: improve the modeling file of git.git
Date: Sun, 20 Jul 2014 23:44:53 +0200
Message-ID: <53CC3855.8050500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: peff@peff.net, john@szakmeister.net, sam@vilain.net,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:45:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8yug-0002ty-KL
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 23:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbaGTVoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 17:44:54 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:58009 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaGTVox (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 17:44:53 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so3196431wib.9
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=QE4kRndEswRGNiVEMoAu/V0Ujty9q9FV1ySHzUXHnlc=;
        b=HWQ+lfADz6v/LAyLie0VbsPJawEex0Q6vO8wNNDuCvsO8vXIkEEMFmsw89+KbdvbwO
         y3CLMN7w3kICpzh/b4rJTTMgNsCCPffBns4CbXJG2EF0hvxj1DOfgT6ByJXa4IZm8W4d
         3aaAmMFWummOUxoUL8FQXdzFydcqvDeBz8V7CTUui2JXJalYsKoTCIh2bHqbH1gzki42
         T9Iq/ZiiRERPNFbO9w9vrNIdGBknICgoLniJYBaYzTvph97PGqmR27Xa7xjbe0XH22Lk
         5ttJA6vg8OBpL3MwaxUOBea5IVa+1Z5fiyVRxZQT2teQ/CDLjNcCiU7hdWlwy4DwMJ7j
         yeng==
X-Received: by 10.194.238.6 with SMTP id vg6mr16478273wjc.24.1405892692261;
        Sun, 20 Jul 2014 14:44:52 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id v14sm32570762wjw.38.2014.07.20.14.44.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jul 2014 14:44:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253937>

Hi Sam, John and Jeff,

I'm writing to you, as you're listed as the 
administrator of the git.git project 
on scan.coverity.com

We're currently seeing lots of false positives
as the xmalloc/xrealloc function is handled not properly
by coverity. There are lots of errors "Allocation too small for type"

Quoting (starting linenumbers are code) from some xrealloc ocurrence:


 95void *xrealloc(void *ptr, size_t size)
 96{
 97        void *ret;
 98
 99        memory_limit_check(size);
100        ret = realloc(ptr, size);

1. Condition "!ret", taking true branch   
2. Condition "!size", taking true branch

101        if (!ret && !size)
   
3. buffer_alloc: "realloc(void *, size_t)" which allocates 1 bytes based on "1UL".   
4. var_assign: Assigning: "ret" = storage allocated by "realloc(ptr, 1UL)".

102                ret = realloc(ptr, 1);
   
5. Condition "!ret", taking false branch

103        if (!ret) {
104                try_to_free_routine(size);
105                ret = realloc(ptr, size);
106                if (!ret && !size)
107                        ret = realloc(ptr, 1);
108                if (!ret)
109                        die("Out of memory, realloc failed");
110        }
   
6. return_dbuffer: Returning allocated array "ret".

111        return ret;
112}

However I have reviewed the function and I'd be pretty sure it would work as expected.
According to https://scan.coverity.com/tune we can upload a modelling file, 
which will allow us to supress such false positive errors.
I believe we'd need to put in the modelling file something like:

	// coverity[+alloc]
	void *xrealloc(void *ptr, size_t size);

and that should do. We'd not need to modify the git.git sources,
but just add such a declaration to the modelling file.

Does anyone of you administrators want to experiment with that?

Cheers,
Stefan
