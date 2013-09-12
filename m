From: Eugene Sajine <euguess@gmail.com>
Subject: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 14:51:41 -0400
Message-ID: <CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 20:51:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKBzV-0005Ry-MB
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 20:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab3ILSvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 14:51:43 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:50904 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab3ILSvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 14:51:42 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so211935wgh.14
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=tfFAY/fxOCgNPcqAyQoc2OzKKkhs2fm9+qsGPwVvd3M=;
        b=NSfpX1Fts3xXJl+XjJbDhMHgjaQ0UPE2QNXv6sCuXgnLnNJPULd/u+/O4XoRVcaF3M
         0mJFi3qHrejpC8chXOkdTiG/MBckjegcQ05ESZKykF9ThauLy8C+iGuhOcvnDv7ZKbaD
         mcBZeFyRFp8339gfsOG//N0rVMh1lfK98W5x6G7GgFRvNrvkUA7bFx7B6Z4RzCZJDHmW
         dA3hQEfgMD3hlrmJKq+KmyKA7bAZNgJZRcqrS/FP9HqoOSBUYsq5GESwm3sQ8m6qC429
         i9PLPXFr+DforR5+XGH+JcwvC1k9QLXI0bMrRGAO+cC/VlPXMLSfhN6tip6v/PCPtOGK
         lG6w==
X-Received: by 10.180.90.197 with SMTP id by5mr23118423wib.43.1379011901115;
 Thu, 12 Sep 2013 11:51:41 -0700 (PDT)
Received: by 10.216.218.197 with HTTP; Thu, 12 Sep 2013 11:51:41 -0700 (PDT)
In-Reply-To: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234672>

Hi,


We are serving repos in closed netwrok via git protocol. We are using
git-daemon access hook (thank you very much for such a great feature)
in order to create push notifications for Jenkins.
I.e. upon the push the access-hook is called and then the curl command
is created and executed. As we have several instances of Jenkins, that
we need to notify (three), the execution of the access-hook can take
some time.

Sometimes we have a situation when the whole chain works fine but
Jenkins git plugin doesn't recognize the changes. I think it happens
because we hit a kind of race condition:

1. Incoming push triggers access-hook
2. notify jenkins 1
3. notify jenkins 2
4. jenkins 1 polls repo but sees no changes
5. notify Jenkins 3
6. the push data transfer finishes - consequent pushes will find
changes w/o any problem

The question is:

Is there a way to avoid that?
Is it possible to have access-hook to be executed after receive?
Is it possible to introduce a parameter that would specify if it needs
to be executed before receive or after?

Thanks,
Eugene
