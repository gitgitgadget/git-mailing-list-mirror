From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 09:41:03 +0200
Message-ID: <48CF630F.4090808@gmail.com>
References: <loom.20080915T222909-709@post.gmane.org> <48CF5B90.5050800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 09:42:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfVCV-0005Js-BX
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 09:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbYIPHlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 03:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbYIPHlI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 03:41:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:8751 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYIPHlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 03:41:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2560399rvb.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=O6pO4DrVL4HvN/9JV5nTn4SXMie3uSkvK+nurIxSCkM=;
        b=rUPALqPaewZ8vqMODC1NL92v/CoK0GafS8/tqJPjtm8lKSyCc7LFNB7VBKFM+7OgJk
         gk6lZZBnFyWqGRYGjrohhNly9HXPY08GlNuPXBKMO5m6+XyxnRIk1x4fjLlYxrm8P9Bb
         CsotYvYiuaNMYfE4VCtPt5kKIId9xjO3VkYZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QVOwDRdk8T5R/C+jYNLz/ZS+cSrFq8r3GS0aZMSaP/K8iIGLnq/QXhUEo6Rw3+eMj7
         aq87fkVA24NSIOtWw02kVj6WXW3hifVIjUtWpslFS+VUKOxbApMq32jPhUgXY+LfNI6C
         zfe7ghS8A6gXZAzyxao4wZannwAI70UgRS1XE=
Received: by 10.114.184.9 with SMTP id h9mr455584waf.151.1221550864710;
        Tue, 16 Sep 2008 00:41:04 -0700 (PDT)
Received: from ?192.168.1.103? ( [71.197.224.64])
        by mx.google.com with ESMTPS id n22sm31064887pof.13.2008.09.16.00.41.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 00:41:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48CF5B90.5050800@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95985>

Johannes Sixt wrote:
>
> You don't need a temporay zip filename in filter mode:
>
>   unzip $UNZIP_OPTS /dev/stdin  # works for me, but not 100% portable
>   zip $ZIP_OPTS - .             # writes to stdout
>
>   
The unzip documentation says "Archives read from standard input are not 
yet supported", so I was a bit worried about using the /dev/stdin 
thing.  Might it be that there are subtle cases where unzip needs to 
seek or rewind?
>> then put in your .git/config something like
>>
>> [filter "opendocument"]
>>         clean = "rezip -p ODF_UNCOMPRESS"
>>         smudge = "rezip -p ODF_COMPRESS"
>>     
>
> Is the smudge filter really necessary? Can't OOo work with files at
> compression level 0?
>   
Yes, you can live perfectly without smudge.  But at times it is not that 
nice. Just think of finding a directory with say 15 lectures as impress 
slides taking 10 times the space it needs, particularly if you need to 
pass those files to someone else. As a matter of fact, ODF xml is very 
verbose and compresses particularly well having long tags.
But you might want to compress -1 rather than the default in smudge to 
speed it up a little.  Can be done either adding a new profile to the 
script (say ODF_COMPRESS_FAST) or by adding --zip_opts -1 to the smudge 
command line.
Also, we might want to add some -n suffixes to zip, to prevent it from 
trying to compress a few things like .png or .jpeg images and that have 
their own compression.  That should gain us some speed in smudging.

In any case - but this is just my feeling - it is much more disturbing 
the delay that the clean filter introduces in operations like add or 
status or commit, than the one introduced by the (slower) smudge filter 
in checkout.  There must be some psychological reason for that.  
Possibly we are "programmed" to accept waiting when we need to get 
something and conversely we are impatient when someone should accept 
something from us.

Sergio
