From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] git-instaweb: Add support for running gitweb via
	'plackup'
Date: Sun, 23 May 2010 09:31:20 +0000
Message-ID: <20100523093120.GB3426@dcvr.yhbt.net>
References: <1274290298-19245-1-git-send-email-jnareb@gmail.com> <201005192252.49461.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 11:31:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7X6-0001gN-Sl
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab0EWJbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:31:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55633 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699Ab0EWJbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:31:14 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id AECC91F4EF;
	Sun, 23 May 2010 09:31:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <201005192252.49461.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147566>

Jakub Narebski <jnareb@gmail.com> wrote:
> Do you have any idea on how to synchronize those two processes, the web
> server and the web client (web browser), so that web browser is run only
> after web server prints that it is ready to accept connection?

Your polling http_is_ready() function is fine, and really the only
portable solution across all servers (and OSes).

But if your webserver lets you run arbitrary code hooks after it
binds the listen socket, what I do when writing integration tests
is have it open a FIFO for writing.

Adapted and abridged from the Rainbows! web server test suite, the
following config snippet is from the config file for the Rainbows! web
server:
---------------- rainbows.conf.rb -----------------
after_fork do |server, worker|
  # test script will block while reading from the FIFO,
  # so notify the script on the first worker we spawn
  # by opening the FIFO
  if worker.nr == 0
    File.open("/path/to/fifo", "wb") { |fp| fp.syswrite "START" }
  end
end
---------------------------------------------------

And then in the test script:
----------- my-integration-test.sh ----------------
set -e
mkfifo /path/to/fifo
# start the server
rainbows --daemonize --config-file rainbows.conf.rb

# "cat /path/to/fifo" will block until the after_fork hook is called
# in rainbows.conf.rb
test xSTART = x"$(cat /path/to/fifo)"

# server is up, run the rest of the tests...
---------------------------------------------------

-- 
Eric Wong
