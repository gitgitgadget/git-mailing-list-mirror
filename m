From: Rogan Dawes <lists@dawes.za.net>
Subject: Type mismatches in safe_read and friends?
Date: Mon, 26 Mar 2007 16:13:10 +0200
Message-ID: <4607D4F6.80703@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 16:14:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVpxS-0006NT-C3
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 16:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbXCZONO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbXCZONO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 10:13:14 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:55560 "EHLO
	spunkymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752659AbXCZONN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 10:13:13 -0400
Received: from [192.168.201.103] (dsl-146-24-118.telkomadsl.co.za [165.146.24.118])
	by spunkymail-a2.g.dreamhost.com (Postfix) with ESMTP id 03DBD87A89
	for <git@vger.kernel.org>; Mon, 26 Mar 2007 07:13:10 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43154>

Hi folks,

I'm starting to learn a little C, and I figured I'd learn from the 
masters ;-) I needed to read in some data from the network, and I 
figured the safe_* calls would be a good example of how to do it correctly.

So, I took a look, and found:

static void safe_read(int fd, void *buffer, unsigned size)
{
         int n = 0;

         while (n < size) {
                 int ret = xread(fd, (char *) buffer + n, size - n);
                 if (ret < 0)
                         die("read error (%s)", strerror(errno));
                 if (!ret)
                         die("The remote end hung up unexpectedly");
                 n += ret;
         }
}


Surely size and 'n' should have the same signed-ness?

And, in fact, shouldn't they actually be size_t, rather than 'int', 
since xread is defined as:

static inline ssize_t xread(int fd, void *buf, size_t len)
{
         ssize_t nr;
         while (1) {
                 nr = read(fd, buf, len);
                 if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
                         continue;
                 return nr;
         }
}

And finally, 'ret' in safe_read should be a 'ssize_t', not an int, right?

Or is it just a case that we don't really care, since we control the 
ranges of the values, and the underlying types are int anyway? Patches 
to follow if I get an indication that anyone cares, otherwise I'd be 
posting my question to a C newbies group. ;-)

Rogan
