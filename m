From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/2] sha1_file: Add sha1_object_type_literally and
 export it.
Date: Wed, 25 Feb 2015 15:15:52 -0500
Organization: Twitter
Message-ID: <1424895352.2968.8.camel@leckie>
References: <54EDACC9.5080204@gmail.com>
		 <1424862460-13514-1-git-send-email-karthik.188@gmail.com>
	 <1424888526.2968.3.camel@leckie> <54EE29AD.4060802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 21:16:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQiNG-00063m-NE
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 21:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbbBYUP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 15:15:58 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:33384 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbBYUP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 15:15:58 -0500
Received: by qcxm20 with SMTP id m20so5025356qcx.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 12:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=w5f9kf+G5LNLURJg8p0ad5N9ivCFrEhyfgmyrjip7qM=;
        b=cwN1BkKIGJlbdxvbl4mTz/IbD1nfJ1Ttx1nHvWkKPLmlPYchno3SjF3ymW+cmXbMyT
         KFYdWpqwCe+19Y1mdlxQ9US81jV4+p3/vQqQK2W5N/49o8sipDzdpi8qJ1fcWjc6QYsp
         uiMArQ71LrDAAkIMA7ckh+rH8TEpTTEH9wmjLw2EtjGZbz5RSthAn/g+YoExbfsSiBEe
         1noFOuyZGjZ0xmzqXU4q+heXpfFNVTq0ZFypM7hH5rhcB6YEj8qKfC0/fVyeIDlqCOC/
         JrN+wHyO1qfwNjv/IYf33ChQeMt0SljtnUFt0fk8t4QIdf8YIeDXHFSyzMDtdM0Y4ZxT
         uxBg==
X-Gm-Message-State: ALoCoQkKExaDbHBmUHn1m6QuZjghnbPuuHLyfSt4q/gEtiwJAZoar2pDcYN6UFMsRvqKFg3vq9lA
X-Received: by 10.140.234.17 with SMTP id f17mr11083340qhc.64.1424895357255;
        Wed, 25 Feb 2015 12:15:57 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id 69sm5285263qgh.5.2015.02.25.12.15.55
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 12:15:56 -0800 (PST)
In-Reply-To: <54EE29AD.4060802@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264411>

On Thu, 2015-02-26 at 01:29 +0530, karthik nayak wrote:
> 
> On 02/25/2015 11:52 PM, David Turner wrote:
> > On Wed, 2015-02-25 at 16:37 +0530, Karthik Nayak wrote:
> >> +	unsigned long mapsize;
> >> ...
> >> +	map = map_sha1_file(sha1, &mapsize);
> >
> > I know this is a pre-existing issue, but I'm not sure "unsigned long" is
> > the right type here.  Shouldn't it be a size_t?
> I got the type from the function definition of map_sha1_file(), which is 
> "void *map_sha1_file(const unsigned char *sha1, unsigned long *size)"

Yep. That's why I describe it as a pre-existing issue - it's not your
fault that the type is funny.  But it might be worth cleaning up while
you're in here.  Or it might not -- maybe I'm totally off base and the
type is correct.

> >
> >> +	if (!map)
> >> +		return -1;
> >> +	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> >> +		status = error("unable to unpack %s header",
> >> +			       sha1_to_hex(sha1));
> >> +
> >> +	for (i = 0; i < 32; i++) {
> >
> > This number should probably be a constant.
> Do you want me to define it as a preprocessor directive?

Sounds good to me.

> >> +		if (hdr[i] == ' ') {
> >> +			type[i] = '\0';
> >> +			break;
> >> +		}
> >> +		type[i] = hdr[i];
> >> +	}
> >
> > type might end up without a trailing \0 here in the case where hdr has
> > no space in it.  Is this possible?
> What's possible is when the object type name is greater than 32bytes 
> "hdr" will not be able to hold the whole type, its a tradeoff, I guess I 
> should put a null terminator at the end of "hdr". What do you suggest?

Is it an error for the object type name to be > 32 bytes?  If there is
no max length, then maybe you should use the strbuf API for this.
Silently truncating is probably the wrong thing to do, and leaving it
unterminated is dangerous unless callers know how to handle that case.
If it is an error, then you should return an error code.
