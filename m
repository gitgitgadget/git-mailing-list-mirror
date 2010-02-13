From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: 'git add' corrupts repository if the working directory is modified as it runs
Date: Sat, 13 Feb 2010 15:39:53 +0100
Message-ID: <201002131539.54142.trast@student.ethz.ch>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Zygo Blaxell <zblaxell@gibbs.hungrycats.org>,
	<git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Feb 13 15:40:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgJA9-0002Ol-US
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 15:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677Ab0BMOj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 09:39:57 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:14432 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab0BMOj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 09:39:56 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 13 Feb
 2010 15:39:54 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 13 Feb
 2010 15:39:54 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <20100213133951.GA14352@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139804>

On Saturday 13 February 2010 14:39:52 Ilari Liusvaara wrote:
> On Sat, Feb 13, 2010 at 06:12:38AM -0600, Jonathan Nieder wrote:
> > 
> > With the current code, write_sha1_file() will hash the file, notice
> > that object is already in .git/objects, and return.  With a
> > read-hash-copy loop, git would have to store a (compressed or
> > uncompressed) copy of the file somewhere in the meantime.
> 
> It could be done by first reading the file and computing hash,
> if the hash matches existing object, return that hash. Otherwise
> read the file for object write, hashing it again and use that value
> for object ID.

That is still racy.  The real problem is that the file is mmap()ed,
and git then first computes the SHA1 of that buffer, next it
compresses it.[*]

Due to the last sentence in the following snippet from mmap(2):

  MAP_PRIVATE
           Create a private copy-on-write mapping.  Updates to the map-
           ping are not visible to other  processes  mapping  the  same
           file,  and  are  not carried through to the underlying file.
           It is unspecified whether changes made to the file after the
           mmap() call are visible in the mapped region.

This is racy despite the use of MAP_PRIVATE: the mapped contents can
change at any time.

AFAICS there are only two possible solutions:

* Copy the file (possibly block-by-block) as we go, to make sure that
  the data we SHA1 is the same we compress.

* Unpack and re-hash the compressed data to verify that the SHA1 is
  correct.  In case of failure either retry (but you could have to do
  this infinitely often if the user just hates you!) or abort.

(Of course, in neither case does the user have any sort of guarantee
about what data ended up in the repository, but he never had that, we
only try to ensure repo consistency.)


[*] The "do we have this" check actually happens before the
compression, and that arm is thus race-free.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
