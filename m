From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: undoing changes with git-checkout -f
Date: Mon, 9 Jan 2006 23:18:36 -0800
Message-ID: <20060110071836.GR18439@ca-server1.us.oracle.com>
References: <43C2D2C4.2010904@cc.jyu.fi> <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net> <20060110045533.GO18439@ca-server1.us.oracle.com> <7vk6d8aaln.fsf@assigned-by-dhcp.cox.net> <20060110063247.GP18439@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ILuaRSyQpoVaJ1HG"
Cc: lamikr <lamikr@cc.jyu.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 08:18:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwDmJ-00077f-Sb
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 08:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWAJHSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 02:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWAJHSp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 02:18:45 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:65410 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750969AbWAJHSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 02:18:44 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k0A7IbLf015743;
	Tue, 10 Jan 2006 00:18:37 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0A7Ia6f009130;
	Tue, 10 Jan 2006 00:18:36 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0A7IalZ009124
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 00:18:36 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1EwDm8-0000X0-VJ; Mon, 09 Jan 2006 23:18:36 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060110063247.GP18439@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14411>


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2006 at 10:32:47PM -0800, Joel Becker wrote:
> 	Here's what I did.  I modified the usual
> ssh-tunnel-over-SSL-CONNECT script to honor http_proxy.  I've attached
> it.  With this, I do as so:

	Bug in the script closing one side of the connection.  Corrected
version attached.

Joel

-- 

"I'm drifting and drifting
 Just like a ship out on the sea.
 Cause I ain't got nobody, baby,
 In this world to care for me."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

--ILuaRSyQpoVaJ1HG
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

$parent = $$;
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
    sleep 2;
    kill(15,$parent);
}



--ILuaRSyQpoVaJ1HG--
