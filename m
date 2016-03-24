From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 09/17] Add watchman support to reduce index refresh
 cost
Date: Thu, 24 Mar 2016 13:58:55 -0400
Organization: Twitter
Message-ID: <1458842335.28595.10.camel@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
	 <1458349490-1704-10-git-send-email-dturner@twopensource.com>
	 <56F3EFF4.30500@jeffhostetler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
	pclouds@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:59:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9XD-0004hz-5G
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbcCXR7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:59:00 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34708 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbcCXR66 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:58:58 -0400
Received: by mail-qg0-f48.google.com with SMTP id c67so10816931qgc.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :mime-version:content-transfer-encoding;
        bh=EmiGtlUUUcUHoat8lTYhdv4c2BlgZrmFFKbJaim4Crk=;
        b=JbVLyHC5Rs8o5aLbWEB6VFPKlpIJcQE/Pu+UaHeuurQFKdXG1i9yXS7K9mDu1tQYdD
         1h72tpmrfdtjrbCp+/xy1pJUjzUKdlM5lSpkS56QuAFYMJL/EvI/OsYyif1YVaw3RyR7
         EYov4LmHkssP1b/tkK+sQBooOJaNhaWaGk1+3qz0UwwcdMG1fhRco16rYgZzqMdp1t5y
         9jgMSXwvD1sp/pP3A9nyPrs6Wq4Sl6c+yuR6J2tBffvplK3DmHVxEToKwF8iH2my1C3J
         us4ceewetjyFRTxdNJcG2ngExCDIONLbe4FDIaW69ighCLuo3gM9DtbQKrAtj6WS3Uoc
         40aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EmiGtlUUUcUHoat8lTYhdv4c2BlgZrmFFKbJaim4Crk=;
        b=kcWF9NVOGqd++xUqj6LCy6MTUmczB2PatDmPPBMgjUX3rytenJy2DrIlGMXcEpDAe1
         adyu4SvwbZ5VSZCUSd9HbxNmDEeBQjS0hnpC4a5JX4X5mDCtbBkccjZXflCekp9E9SCP
         fx0MUIj05lm+kWheMDxR8NzTreXXNZ1nbn6B+Y5PS6bpGvZypEadz2L0W1DHzREicNGQ
         qYAIlNUkkAH4M9JVhmBTsJorvQaFVIZ+/chUMu+xcabJkotX990y9A2OyjXdbZ8tIrrq
         ssYfFudIr+ZKxxq7Z+XQ9MBm0cVXdmpfvUaJQQBh+U9lQP9o2X9tkFNvGpqS4VCDxe3c
         EFeg==
X-Gm-Message-State: AD7BkJKyITZUwcirLeNXcvQJJaYyMCGh9l6K7BLFxbwWC4Dq9EQYkhwF5yZm0CuNtMXV8w==
X-Received: by 10.140.176.206 with SMTP id w197mr13021207qhw.76.1458842337353;
        Thu, 24 Mar 2016 10:58:57 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3704480qkb.39.2016.03.24.10.58.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 10:58:56 -0700 (PDT)
In-Reply-To: <56F3EFF4.30500@jeffhostetler.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289774>

On Thu, 2016-03-24 at 09:47 -0400, Jeff Hostetler wrote:
> I'm seeing wm->name have value ".git" rather than ".git/" on Linux.
> 
> 
> On 03/18/2016 09:04 PM, David Turner wrote:
> > +		if (!strncmp(wm->name, ".git/", 5) ||
> > +		    strstr(wm->name, "/.git/"))
> > +			continue;
> 

Thanks.  I don't think I considered the case of .git itself being
modified, although clearly files are occasionally created/deleted in
there.  I'm going to fix this by ignoring all directories, since we'll
capture untracked-cache changes via files in those dirs.
