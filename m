From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] refs.c: repack_without_refs may be called without error
 string buffer
Date: Thu, 20 Nov 2014 10:35:23 -0800
Message-ID: <20141120183523.GD15945@google.com>
References: <1416506666-5989-1-git-send-email-sbeller@google.com>
 <1416507040-6576-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, sahlberg@google.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWZh-0003Tk-P8
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956AbaKTSfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:35:21 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36294 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756860AbaKTSfV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:35:21 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so3247580ieb.23
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SYJQCJi7Ynhg9BHsQ9ZnrYz2IbyVabRB3xuznmHix7Y=;
        b=U/5WBu8T74XIr1FvzZv3dg6yeXm8anuHoXjgpiD3aLfQYTKBDQq2gIXXUvbUPbYxbZ
         FBnXwpDHCYR1it9b7mvZcX7vrN513aCvOfF+LbJfcqxm3+zQLwZozr/ADdKkEn3CU7C4
         flIFZM6QTrT8WeNc++HkL5s4u66xtuzJ40OvLOgGXZArF+B5WY1EKJ6tiUkk31/hhK9u
         ujUZyknSdJ/fxUQSmBD3TSQNJRJRGZmohPjKQdgQj6zXb60LG8yCA/ah29jBK6V/Lp6j
         PBcQnttKGazvcJDGH9bbRufbBjO9jaMNukQabX61ni3iZ+4aSil6qVj1nZNrKsM6Fm1D
         +XRQ==
X-Received: by 10.107.128.87 with SMTP id b84mr49044188iod.42.1416508520322;
        Thu, 20 Nov 2014 10:35:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id i3sm1582807iod.19.2014.11.20.10.35.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 10:35:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416507040-6576-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> If we don't pass in the error string buffer, we skip over all
> parts dealing with preparing error messages.

Please no.

We tried this with the ref transaction code.  When someone wants
to silence the message, it is cheap enough to do

	struct strbuf ignore = STRBUF_INIT;

	if (thing_that_can_fail_in_an_ignorable_way(..., &ignore)) {
		... handle the failure ...
	}

The extra lines of code make it obvious that the error message is
being dropped, which is a very good thing.  The extra work to format a
message in the error case is not so bad and can be mitigated if the
error is a common normal case by passing a flag to not consider it an
error.

Silently losing good diagnostic messages when err == NULL would have
the opposite effect: when there isn't a spare strbuf to put errors in
around, it would be tempting for people coding in a hurry to just pass
NULL, and to readers it would look at first glance like "oh, an
optional paramter was not passed and we are getting the good default
behavior".

This is not a theoretical concern --- it actually happened.

My two cents,
Jonathan
