From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: 'git add' corrupts repository if the working directory is
 modified as it runs
Date: Sat, 13 Feb 2010 15:39:52 +0200
Message-ID: <20100213133951.GA14352@Knoppix>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100212002741.GB9883@progeny.tock>
 <20100212012314.GC24809@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 14:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgIE9-00022P-PC
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 14:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab0BMNj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 08:39:58 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:44290 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab0BMNj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 08:39:57 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 170B313B3A9;
	Sat, 13 Feb 2010 15:39:56 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0225DEDEBE; Sat, 13 Feb 2010 15:39:55 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id BD47E158A79;
	Sat, 13 Feb 2010 15:39:52 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100213121238.GA2559@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139795>

On Sat, Feb 13, 2010 at 06:12:38AM -0600, Jonathan Nieder wrote:
> 
> This leaves me nervous about speed.  Consider the following simple
> case: someone the file to be added is already in the object
> repository somewhere (maybe the user has tried this code before, or
> a file was renamed with 'mv', or a patch applied with 'patch', or an
> unmount and remount dirtied the stat information).
> 
> With the current code, write_sha1_file() will hash the file, notice
> that object is already in .git/objects, and return.  With a
> read-hash-copy loop, git would have to store a (compressed or
> uncompressed) copy of the file somewhere in the meantime.

It could be done by first reading the file and computing hash,
if the hash matches existing object, return that hash. Otherwise
read the file for object write, hashing it again and use that value
for object ID.

This would require two hash computations in non-existing case,
but SHA-1 is pretty fast. If the first computation produces match,
then it doesn't matter if file is modified as adding and modifying
in parallel results undefined contents anyway (just that it should
not corrupt the repository).

-Ilari
