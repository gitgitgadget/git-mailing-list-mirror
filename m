From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 09/16] Read index-v5
Date: Wed, 8 Aug 2012 09:41:38 +0200
Message-ID: <20120808074138.GD867@tgummerer.surfnet.iacbox>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-10-git-send-email-t.gummerer@gmail.com>
 <7v4nog1twd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 09:41:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz0tn-00026k-LB
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 09:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528Ab2HHHln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 03:41:43 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53753 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab2HHHll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 03:41:41 -0400
Received: by wibhm11 with SMTP id hm11so3582595wib.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nqRDFgzfO/FduAfATBXsGmVKmMeBmaSuQSJxIwzb9Xs=;
        b=ZQBKFTS/2fpmOBiJpdTzOsL6RRkenk5m48+eVHQlu8ZwFfkv1Pjotuz848KgRhG58B
         VvD+LrWCxARY1yGpb56qLMw0rz5erUA0VHmkTavjycUbFKZzAUieVEUTfN0r7k+y4Q8s
         5wQATic+DZsh/XlTu1bTEXmcEIpDMNPjxi/MgaNyqWmQ793DW7l9ahTOWkNn5szWGXvX
         mLCZo6qBPHKgy67IA9i0Sg/CImDgVMD1TTDwWz+r18Y4X+fIQ9FVIsVIRyLGP2oeGlTX
         PhKUkOSahiAXl7OS0mvn4ZiIt75KF/9PNEjS7TA+KLl3wwOv8C+jiF6Y9qfPbmrScvNz
         ajjw==
Received: by 10.216.147.4 with SMTP id s4mr9532852wej.9.1344411700771;
        Wed, 08 Aug 2012 00:41:40 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id ef5sm5656160wib.3.2012.08.08.00.41.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 00:41:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4nog1twd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203067>

On 08/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +static struct directory_entry *read_directories_v5(unsigned int *dir_offset,
> > +				unsigned int *dir_table_offset,
> > +				void *mmap,
> > +				int mmap_size)
> > +{
> > +	int i, ondisk_directory_size;
> > +	uint32_t *filecrc, *beginning, *end;
> > +	struct directory_entry *current = NULL;
> > +	struct ondisk_directory_entry *disk_de;
> > +	struct directory_entry *de;
> > +	unsigned int data_len, len;
> > +	char *name;
> > +
> > +	ondisk_directory_size = sizeof(disk_de->flags)
> > +		+ sizeof(disk_de->foffset)
> > +		+ sizeof(disk_de->cr)
> > +		+ sizeof(disk_de->ncr)
> > +		+ sizeof(disk_de->nsubtrees)
> > +		+ sizeof(disk_de->nfiles)
> > +		+ sizeof(disk_de->nentries)
> > +		+ sizeof(disk_de->sha1);
> > +	name = (char *)mmap + *dir_offset;
> > +	beginning = mmap + *dir_table_offset;
> 
> Notice how you computed name with pointer arithmetic by first
> casting mmap (which is "void *") and when computing beginning, you
> forgot to cast mmap and attempted pointer arithmetic with "void *".
> The latter does not work and breaks compilation.
> 
> The pointer-arith with "void *" is not limited to this function.

Sorry for not noticing this, it always compiled fine for me. Guess
I should use -pedantic more often ;-)

> Please check the a band-aid (I wouldn't call it a fix-up) patch I
> added on top of the series before queuing the topic to 'pu'; it is
> primarily to illustrate the places I noticed that have this issue.
> 
> I do not necessarily suggest that the way the band-aid patch makes
> it compile is the best approach.  It might be cleaner to use a saner
> type like "char *" (or perhaps "const char *") as the type to point
> at a piece of memory you read from the disk.  I haven't formed an
> opinion.
> 
> Thanks.

I've used the type of the respective assignment for now. e.g. i have
struct cache_header *hdr, so I'm using
hdr = (struct cache_header *)mmap + x;

read-cache-v5.c compiles with -pedantic without warnings.
