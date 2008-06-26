From: logank@sent.com
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 16:36:27 -0700
Message-ID: <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com> <20080626204606.GX11793@spearce.org> <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 01:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC11s-0002gV-Re
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 01:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYFZXgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 19:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbYFZXgc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 19:36:32 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54774 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753673AbYFZXgb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2008 19:36:31 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id BF5D412F630;
	Thu, 26 Jun 2008 19:36:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 26 Jun 2008 19:36:29 -0400
X-Sasl-enc: wxjlBvgJ1dr3PQ9wu/jSunm3PgRG6/3ahYjekG1YpIyP 1214523389
Received: from [172.16.9.26] (unknown [199.0.156.239])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 02B92332AE;
	Thu, 26 Jun 2008 19:36:28 -0400 (EDT)
In-Reply-To: <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86502>

On Jun 26, 2008, at 1:56 PM, Junio C Hamano wrote:

>> "The file shouldn't be short unless someone truncated it, or there
>> is a bug in index-pack.  Neither is very likely, but I don't think
>> we would want to retry pread'ing the same block forever.
>
> I don't think we would want to retry even once.  Return value of 0  
> from
> pread is defined to be an EOF, isn't it?

No, it seems to be a simple error-out in this case. We have 2.4.20  
systems with nfs-utils 0.3.3 and used to frequently get the same error  
while pushing. I made a similar change back in February and haven't  
had a problem since:

diff --git a/index-pack.c b/index-pack.c
index 5ac91ba..85c8bdb 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -313,7 +313,14 @@ static void *get_data_from_pack(struct  
object_entry *obj)
	src = xmalloc(len);
	data = src;
	do {
+		// It appears that if multiple threads read across NFS, the
+		// second read will fail. I know this is awful, but we wait for
+		// a little bit and try again.
		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
+		if (n <= 0) {
+			sleep(1);
+			n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
+		}
		if (n <= 0)
			die("cannot pread pack file: %s", strerror(errno));
		rdy += n;

I use a sleep request since it seems less likely that the other thread  
will have an outstanding request after a second of waiting.

-- 
                                                         Logan Kennelly
       ,,,
      (. .)
--ooO-(_)-Ooo--
