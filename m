From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: undoing changes with git-checkout -f
Date: Mon, 9 Jan 2006 22:32:47 -0800
Message-ID: <20060110063247.GP18439@ca-server1.us.oracle.com>
References: <43C2D2C4.2010904@cc.jyu.fi> <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net> <20060110045533.GO18439@ca-server1.us.oracle.com> <7vk6d8aaln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5gxpn/Q6ypwruk0T"
Cc: lamikr <lamikr@cc.jyu.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 07:33:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwD3z-0006iq-Dr
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 07:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWAJGc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 01:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWAJGc4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 01:32:56 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:45883 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750810AbWAJGcz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 01:32:55 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k0A6WmJC012942;
	Mon, 9 Jan 2006 23:32:48 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0A6Wl2A018788;
	Mon, 9 Jan 2006 23:32:47 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0A6WkSH018777
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Jan 2006 23:32:47 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1EwD3n-0008Jp-Pl; Mon, 09 Jan 2006 22:32:47 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6d8aaln.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14408>


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2006 at 09:57:40PM -0800, Junio C Hamano wrote:
> Joel Becker <Joel.Becker@oracle.com> writes:
> > 	Can we teach the git:// fetch program to use CONNECT over HTTP
> > proxies?  rsync can do this, but git:// cannot, so firewalls that block
> > 9418 mean we use rsync://
> > 	I'm mostly offline this week or I'd take a stab at it.
> 
> It's been there for quite some time, although I never liked the
> way it interfaces with the outside world.
> 

	Ugly snipped...

> It is a bit inconvenient that "git clone" wrapper cannot be used
> on an existing repository, and without an existing repository
> you cannot have .git/config. You could have the config file in
> your site-wide template area, but admittably it is a bit
> awkward.

	Here's what I did.  I modified the usual
ssh-tunnel-over-SSL-CONNECT script to honor http_proxy.  I've attached
it.  With this, I do as so:

	# cp git-tunnel.pl /usr/local/bin
	# export http_proxy="http://my-proxy.my.com:80/"
	# GIT_PROXY_COMMAND="/usr/local/bin/git-tunnel.pl" git clone git://git.kernel.org/pub/scm/... localsource
	# cd localsource
	# vi .git/config
		[core]
			gitproxy = /usr/local/bin/git-tunnel.pl

	This is working for me.  I'd really rather have the tunneling
code be part of connect.c, and have core.proxymethod=external use the
current core.gitproxy method and core.proxymethod=http use $http_proxy.
	But this will suffice for now :-)

Joel

-- 

Life's Little Instruction Book #198

	"Feed a stranger's expired parking meter."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

--5gxpn/Q6ypwruk0T
Content-Type: text/x-perl; charset=us-ascii
Content-Disposition: attachment; filename="git-tunnel.pl"

#!/usr/bin/perl
#
# git-tunnel.pl	
#
# Usage: git-tunnel.pl ssl-proxy port destination_host port
#
# This script can be used by git as a "core.gitproxy" to 
# traverse a www-proxy/firewall that supports the http CONNECT 
# command described in
# http://home.netscape.com/newsref/std/tunneling_ssl.html
#
# It uses the http_proxy (or HTTP_PROXY) variable to determine the
# proxy to connect to.  Put the path to this script in the environment
# variable GIT_PROXY_COMMAND, or better yet, insert the core.gitproxy
# definition in .git/config.
#
#      .
#      .
#      [core]
#          gitproxy = /path/to/git-tunnel.pl
#      .
#      .
#
# Written by Urban Kaveus <urban@statt.ericsson.se>
# Modified to use http_proxy by Joel Becker <joel.becker@oracle.com>

use Socket;

# Parse command line arguments

if ( $#ARGV != 1 ) {
    print STDERR "Usage: $0 destination port\n";
    print STDERR $#ARGV, "\n";
    exit(1);
}

$proxy_url = $ENV{'http_proxy'};
if (!$proxy_url) {
    $proxy_url = $ENV{'HTTP_PROXY'};
}

$proxyport = 80;
if ($proxy_url =~ /^https?:\/\/([^:]+)\/$/) {
    $sslproxy = $1;
} elsif ($proxy_url =~ /^https?:\/\/([^:]+):([1-9][0-9]*)\/$/) {
    $sslproxy = $1;
    $proxyport = $2;
} else {
    print STDERR "Invalid proxy specification: \"$proxy_url\"\n";
    exit(1);
}

$destination = shift;
$destport    = shift;

# Set up network communication

($protocol) = (getprotobyname("tcp"))[2];
($proxyip)  = (gethostbyname($sslproxy))[4];
$localaddr  = pack('S n a4 x8', &AF_INET, 0, "\0\0\0\0");
$proxyaddr  = pack('S n a4 x8', &AF_INET, $proxyport, $proxyip);

socket (PROXY, &AF_INET, &SOCK_STREAM, $protocol) or
    die("Failed to create cocket");
bind (PROXY, $localaddr) or
    die("Failed to bind socket");
connect (PROXY, $proxyaddr) or
    die("Failed to connect to $sslproxy port $proxyport");

# Force flushing of socket buffers

select (PROXY);  $| = 1; 
select (STDOUT); $| = 1;

# Send a "CONNECT" command to proxy:

print PROXY "CONNECT $destination:$destport HTTP/1.1\r\n\r\n";

# Wait for HTTP status code, bail out if you don't get back a 2xx code.

$_ = <PROXY>;
($status) = (split())[1];

die("Received a bad status code \"$status\" from proxy server") 
    if ( int($status/100) != 2 );

# Skip through remaining part of MIME header

while(<PROXY>) {
    chomp;   # Strip <LF>
    last if /^[\r]*$/;		# Empty line or a single <CR> left
}

# Start copying packets in both directions.

if($child = fork) { # Parent process
    while (sysread(STDIN,$_,4096)) {
        print PROXY;
    }
    sleep 2;
    kill(15,$child) if $child;
}

else { # Child process
    while (sysread(PROXY,$_,4096)) {
        print STDOUT;
    }
}




--5gxpn/Q6ypwruk0T--
