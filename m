From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [PATCH JGIT 1/2] Calculate CRC32 on Pack Index v2
Date: Wed, 25 Mar 2009 14:31:04 +0100
Message-ID: <49CA3218.9090202@gmail.com>
References: <ff6a9c820903231953q29a5ccbk8e5b54c9afdb8abd@mail.gmail.com> <1237962115-22709-1-git-send-email-j16sdiz+freenet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 14:33:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmTEX-0006mT-Lg
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 14:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759473AbZCYNbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 09:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757215AbZCYNbM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 09:31:12 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:42838 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526AbZCYNbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 09:31:11 -0400
Received: by mu-out-0910.google.com with SMTP id g7so17676muf.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=qleUWCVxKIBlvHr40JBIyi0ktdWWMvK9Ray6J/H0gZk=;
        b=r/f0rXPOeCcBHG5fWvm5m0xhpu9kNYCe6ZgytsQ41rjex5pIChEZI4J99UB/1TGSY+
         rSNLyFK8enmeYY+D0Vw57XSylMV4pUhOVw10KL4jYkIfg/8RT80X4XxXr/W5EUqKEtWJ
         Sc4/cCR2i0X4QyB40hlE55uMlk6MshyEuJ4jE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qfRpWIDhTZDfXvsiAL8S6Cu4JUqX5PvMLSNUSdOgUgV5PmbUQeOb/51uOscQd7XIP1
         IcGXabaWNJwyOXeuI6LLmiL5xKXD0V/FmAibaY0pYI0rqtItuzY5cdXrYMs1KPl3n+Mh
         76wTfz6yOGQ4ZeR3RmnVZpm+Vo5ZCXul98Xno=
Received: by 10.102.228.10 with SMTP id a10mr4195767muh.26.1237987866960;
        Wed, 25 Mar 2009 06:31:06 -0700 (PDT)
Received: from ?193.51.208.217? (vis217.inria.fr [193.51.208.217])
        by mx.google.com with ESMTPS id g1sm14196727muf.12.2009.03.25.06.31.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 06:31:06 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <1237962115-22709-1-git-send-email-j16sdiz+freenet@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114602>

Hi,

Thanks for spotting this bug.

Daniel Cheng (aka SDiZ) wrote:

(...)

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
> index 601ce71..d8b50e6 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
> @@ -687,11 +687,13 @@ public class PackWriter {
>  
>  		assert !otp.isWritten();
>  
> +		countingOut.resetCRC32();
>  		otp.setOffset(countingOut.getCount());
>  		if (otp.isDeltaRepresentation())
>  			writeDeltaObject(otp);
>  		else
>  			writeWholeObject(otp);
> +		otp.setCRC((int) countingOut.getCRC32());
>
>   
Huh, now it appears that you made CRC32 really computed;)
I just wonder if it is sensible to compute it always regardless of used 
index version (outputVersion) - for index v1 we don't really need CRC32 
to be computed. I don't have a good idea how can it be avoided in truly 
elegant way, as we cannot rely on the outputVersion checking in this 
code - currently it may became changed after writing pack, but before 
writing index.  But maybe it's not so important issue, as AFAIR v2 is 
already default version for index.

> }
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
> index b0b5f7d..b4ae915 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
> @@ -40,12 +40,16 @@ package org.spearce.jgit.util;
>  import java.io.FilterOutputStream;
>  import java.io.IOException;
>  import java.io.OutputStream;
> +import java.util.zip.CRC32;
>  
>  /**
> - * Counting output stream decoration. Counts bytes written to stream.
> + * Counting output stream decoration. Counts bytes written to stream and 
> + * calculate CRC32 checksum.
>   
IMO it would be better to make CRC32 computation in another decorator 
class, but that's just me.

>   */
>  public class CountingOutputStream extends FilterOutputStream {
>  	private long count;
> +	
> +	private CRC32 crc;
>  
>  	/**
>  	 * Create counting stream being decorated to provided real output stream.
> @@ -55,6 +59,7 @@ public class CountingOutputStream extends FilterOutputStream {
>  	 */
>  	public CountingOutputStream(OutputStream out) {
>  		super(out);
> +		crc = new CRC32();
>  	}
>  
>  	@Override
> @@ -79,10 +84,35 @@ public class CountingOutputStream extends FilterOutputStream {
>  		return count;
>  	}
>  
> +    /**
> +     * Resets CRC-32 to initial value.
> +     */
> +	public void resetCRC32() {
> +		crc.reset();
> +	}
> +
> +    /**
> +     * Returns CRC-32 value.
> +     * @return CRC32
> +     */
> +	public long getCRC32() {
> +		return crc.getValue();
> +	}
> +
> +
>  	/**
>  	 * Reset counter to zero value.
>  	 */
>  	public void reset() {
>  		count = 0;
> +		crc.reset();
> +	}
> +	
> +	/**
> +	 * {@inheritDoc}
> +	 */
> +	public void close() throws IOException {
> +		crc = null;
> +		super.close();
>  	}
>  }
>   
Have you tested that code? It seems that CRC32 updates is  missing in 
write() method... or did I slept too short this night?:)

Best,
Marek
