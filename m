From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 05/20] Reverse pack index implementation: PackReverseIndex
Date: Mon, 16 Jun 2008 18:27:12 +0200
Message-ID: <48569460.4000401@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com> <20080616040635.GU11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:28:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8HYw-0005hT-4H
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbYFPQ1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbYFPQ1S
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:27:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:29409 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYFPQ1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:27:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3300768fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=UqaLKuo4SzSFuexDwCxB/qexezc7Qy8isgHvrx7+th8=;
        b=v3HfgPmNt2wS1rbvssAheNuNofQtHwQENgjRhk1VodP+RNHGcuzdWznVuWfjPuE4Ee
         PEjTB5g+7QjLbvrNWLTLq43wqq12rcVrxoAoe3q64SJwPVFkdSeMoN0T1zVyttuOMhvv
         Z8Y+0NTxGfTpzpf1zW8DLvsn7v4xcf2+yhwjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Jv9zcV7PtlR9y55mcIy3EKWOuwt7J9/xHI9VdQzhUdDGVjIHphgv5STLJPnMMuuxyj
         l4nvIXUKMmgDHqOvEg5Lir/ODu0ZrvK3AVAqNz51S0CD5nIZXHSWTucbmKo7BwnfI4vq
         iIFlWbCx5M6QjjjIMKqDr6JPygQgxDPgBqp44=
Received: by 10.86.65.9 with SMTP id n9mr7978072fga.69.1213633635685;
        Mon, 16 Jun 2008 09:27:15 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id l12sm10619273fgb.6.2008.06.16.09.27.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 09:27:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-5)
In-Reply-To: <20080616040635.GU11793@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85206>

Shawn O. Pearce wrote:
> Marek Zawirski <marek.zawirski@gmail.com> wrote:
>> Let us quickly find ObjectId or next object for specified offset in a
>> pack, in O(log n) time.
> ...
>> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java
> ...
>> +	/**
>> +	 * Object ids corresponding to {@link #offsets32} and {@link #offsets64}.
>> +	 */
>> +	private final int names[];
> 
> This could be smaller if it was an array of indexes into the index,
> rather than the ObjectId itself.  Thus we need only 1 int per object
> and not 5 ints per object.
> 
> But I see why you are doing it; PackIndex.MutableEntry exposes the
> ObjectId and not the nth position of the object within the index.

Hmm, that's smart.
I can change array of names to second level indices, but I think that in 
such a case PackReverseIndex should be an inner class of PackIndex and 
some refactor/additional assumptions at PackIndex may be needed. What do 
you think?

>> +	PackReverseIndex(final PackIndex index) {
>> +		final long count = index.getObjectCount();
>> +		if (count > Integer.MAX_VALUE)
>> +			throw new IllegalArgumentException(
>> +					"Huge indexes (> 2^31 entries) are not supported by jgit, yet");
> 
> For what its worth, this limit is actually:
> 
> 	Integer.MAX_VALUE / Constants.OBJECT_ID_LENGTH / 4
> 
> as you store the entire ObjectId data for the index in a single int[]
> array called names.  So you'll get an ArrayIndexOutOfBoundsException
> or maybe OutOfMemoryError when you try to build names later on, and
> never really hit this case here.
>> +	ObjectId findObject(final long offset) {
>> +		if (offset <= Integer.MAX_VALUE) {
>> +			final int i32 = Arrays.binarySearch(offsets32, (int) offset);
>> +			if (i32 < 0)
>> +				return null;
>> +			final int iNames = i32 * Constants.OBJECT_ID_LENGTH / 4;
> 
> This probably should be:
> 
> 	final int iNames = i32 * (Constants.OBJECT_ID_LENGTH / 4);
> 
> as then we don't overflow the precision of int when i32 is large.
> 
>> +			return ObjectId.fromRaw(names, iNames);
>> +		} else {
>> +			final int i64 = Arrays.binarySearch(offsets64, offset);
>> +			if (i64 < 0)
>> +				return null;
>> +			final int iNames = (i64 + offsets32.length)
>> +					* Constants.OBJECT_ID_LENGTH / 4;
> 
> Again, watch out for overflow.

Right, my faults.

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
