From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git-remote-fd problem
Date: Wed, 10 Sep 2014 17:47:57 +0300
Message-ID: <20140910144756.GA4267@LK-Perkele-VII>
References: <CAOP4-939uAP2Tgofz01F40_Eb0F8GxBsU49HxNvAiyBCW6H08w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jiri Sevcik <jsevcik14@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 16:54:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRjHZ-0008BJ-MR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 16:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbaIJOx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 10:53:57 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:35960 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaIJOxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 10:53:55 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Sep 2014 10:53:55 EDT
Received: from LK-Perkele-VII (a88-112-44-140.elisa-laajakaista.fi [88.112.44.140])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 340E33FE4;
	Wed, 10 Sep 2014 17:47:57 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <CAOP4-939uAP2Tgofz01F40_Eb0F8GxBsU49HxNvAiyBCW6H08w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256749>

On Wed, Sep 10, 2014 at 03:29:00PM +0200, Jiri Sevcik wrote:
> Hi!
> I have problem with using git-remote-fd function. I create two local
> pipes for communication for locally running process git pull. Then I
> start git-upload-pack on remote side (this process is started in
> different part of my code  and it works correctly). Communication runs
> successfully and when remote side finish, I want to close local pipes
> to finish local process. I call close function to all of these pipes,
> but unfortunatelly local process doesnt finish (in this moment
> transfered data aresaved in /.git/object/pack folder in .pack files)
> and hanging on. But if I kill child of this local process, downloaded
> files are unpacked and files are created sucessfully. I think this way
> is not so correct. Can someone help me and tell me what am I doing
> wrong? Thank You. Code is in an attachement (its part of big system).

The remote-fd expects the transport to pass half-closes. So you can't
close all at once.

Let there be pipes W and R and transport connection C.

- W-read should be closed after being passed to remote-fd.
- R-write should be closed after being passed to remote-fd.
- Upon receiving "no more data" from C, close W-write.
- Upon receiving EOF from R-read, close it and signal "no more data"
  to C.

If you have server end, the same applies, but with remote-fd replaced
by upload-pack/upload-archive/receive-pack.


-Ilari
