From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git: avoiding merges, rebasing
Date: Mon, 8 Oct 2007 15:17:59 +0200
Message-ID: <07BCEF3E-90DE-4BB7-8A8C-F03D12293B5F@lrde.epita.fr>
References: <200709301421.52192.bruno@clisp.org> <46FF99E2.8050605@byu.net> <200709302141.25597.bruno@clisp.org> <C64152A3-A5A6-4320-864C-E78E3A60C8E6@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-20-941398284"
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git list <git@vger.kernel.org>
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 15:18:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IesVM-0000wG-UP
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 15:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbXJHNSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 09:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbXJHNSb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 09:18:31 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:56220 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbXJHNSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 09:18:31 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IesVB-0001BV-LB; Mon, 08 Oct 2007 15:18:29 +0200
In-Reply-To: <C64152A3-A5A6-4320-864C-E78E3A60C8E6@lrde.epita.fr>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60321>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-20-941398284
Content-Type: multipart/mixed; boundary=Apple-Mail-19-941398214


--Apple-Mail-19-941398214
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

[as usual, I forgot the attachment...]

On Sep 30, 2007, at 10:27 PM, Benoit SIGOURE wrote:

> On Sep 30, 2007, at 9:41 PM, Bruno Haible wrote:
>
>>> it should be
>>> possible to create a custom [merge "cl-merge"] in your git config  
>>> file,
>>> which points to a script designed specifically for resolving  
>>> changelog
>>> conflicts
>>
>> I would love such a script, instead of constantly having to do  
>> conflict
>> resolution at the top of ChangeLog.
>>
>
> So would I.  I've had this in my TODO list for a long time so if no  
> one else is willing to give it a try, I can try, but it won't be  
> before next week because my schedule is quite busy until then.
>

I finally found some time to hack something and here is my git-merge- 
changelog Perl script.  I tested it quickly and it seems to work  
fine.  It will mess up the ChangeLog entries when a commit actually  
modifies an existing ChangeLog entry.  It needs more testing but I'm  
just throwing this out in the wild for people that have interest in  
this to review.  I will eventually come up with a solution for the  
commits modifying existing entries and a testsuite.

I'm CC-ing the Git ML just in case it interests some more people over  
there.

In order to use it, add the following to your ~/.gitconfig:
[merge "cl-merge"]
         name = GNU-style ChangeLog merge driver
         driver = /path/to/git-merge-changelog %O %A %B
(you can also add it to a specific working copy by adding it in .git/ 
config instead)

Then, in the directory where the ChangeLog is, add a .gitattributes  
file with the following content:
ChangeLog       merge=cl-merge

For more information, see man gitattributes.

Let me know if something goes wrong.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory


--Apple-Mail-19-941398214
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0711;
	name=git-merge-changelog
Content-Disposition: attachment;
	filename=git-merge-changelog

#!/usr/bin/env perl
# Define a merge driver to use with Git to merge GNU-style ChangeLog entries.
# Copyright (C) 2007  Benoit Sigoure.

my $VERSION = '2007-10-08 12:33'; # UTC

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
# USA.

use warnings;
use strict; # Oh yes, spank me baby!

my $usage = "usage: $0 [OPTION] OLD CURRENT OTHERS\n";

# help(VAL)
# ---------
# Print the usage and exit with VAL.
sub help($)
{
  print <<EOF;
$usage
Merge driver for Git to merge GNU-style ChangeLog entries.  OLD is the the
merge ancestors' version, CURRENT is the current version, OTHERS is the
other branches' version.  The result of the merge is left in the file
CURRENT unless the option --output is used.

  --help             display this help and exit
  --version          output version information and exit
  -o, --output=FILE  specify an output file

Report bugs to <tsuna\@lrde.epita.fr>
EOF
  exit (shift);
}

sub version() # subversion is wrong!  Use Git instead!  ;D
{
  print <<EOF;
git-merge-changelog $VERSION
Copyright (C) 2007  Benoit Sigoure
License GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
EOF
}

my $debug = 0;
# debug(MSG [, NL])
# ----------
# Print MSG on stderr if debugging is enabled.  If NL is not given or is true,
# an additionnal \n is printed.
sub debug($;$)
{
  return if not $debug;
  my ($msg, $nl) = @_;
  print STDERR $msg . (defined($nl) && !$nl ? '' : "\n");
}

# Return value of the script.
my $res = 0;

# error(MSG)
# ----------
# Print MSG on stderr and set the return value to be 1 (does not exit).
sub error($)
{
  print STDERR "@_\n";
  &debug;
  $res = 1;
}

# Output file.
my $output;

# Parse ARGV, return the list of files to merge.
sub parse_options()
{
  use Getopt::Long;
  Getopt::Long::config('bundling', 'pass_through');
  Getopt::Long::GetOptions
    (
     'h|help'        => sub { help(0); },
     'version'       => sub { version; },
     'debug'         => \$debug,
     'o|output=s'    => \$output,
    )
    or die;

  foreach my $arg (@ARGV)
  {
    if ($arg =~ /^-./)
    {
      print STDERR "$0: unrecognized option or bad usage for `$arg'\n";
      print STDERR $usage;
      print STDERR "Try `$0 --help' for more information.\n";
      exit 1;
    }
  }
  return @ARGV;
}

my @input_files = parse_options();
print STDERR $usage and exit(1) if $#input_files != 2;

$output = $input_files[1] unless defined $output;
debug "result of the merge will be written to $output";

foreach my $f (@input_files)
{
  print STDERR "$0: `$f': No such file or not readable\n"
    and exit(1)
    unless -r $f;
}

# Hash of ChangeLog entries.
# The keys are dates of the form YYYY-MM-DD.
# The values are arrays of ChangeLog entries.
my %entries;

# add_entry(DATE, TEXT)
# Add the ChangeLog entry TEXT.  DATE is of the form YYYY-MM-DD.
sub add_entry($$)
{
  my ($date, $entry) = @_;
  return if not defined $date or not defined $entry;

  # Prevent duplicate entries.
  foreach my $i (@{$entries{$date}})
  {
    if ($i eq $entry)
    {
      debug "Duplicate entry $date";
      return;
    }
  }
  debug "Got an entry $date";
  # Add the new entry.
  push (@{$entries{$date}}, $entry);
}

# Optional Copyright notice often found at the end of ChangeLogs.
my $copyright_notice;
# File in which we found the Copyright notice.
my $copyright_notice_file;

foreach my $f (@input_files)
{
  # Buffer for the current ChangeLog entry.
  my $cur_entry;
  # Date of the current ChangeLog entry.
  my $cur_date;

  open(IN, $f) or die("Could not open '$f' for reading: $!");
  debug ">>> processing `$f'";
  while (<IN>)
  {
    if ($_ !~ /^[-0-9]{10} .*@.*/ && defined($cur_entry))
    {
      debug("adding...", 0);
      $cur_entry .= $_;
    }
    elsif (/^([-0-9]{10}) .*@.*/)
    {
      add_entry($cur_date, $cur_entry);
      $cur_date = $1; # Fragile, assumes that add_entry does use RE.
      $cur_entry = $_;
    }
    elsif ($_ !~ /^\s*$/)
    {
      error("$0: $f:$.: Junk line: $_");
    }
  }
  close(IN) or die("Error while closing '$f': $!");

  # The last entry might contain a Copyright notice that needs to be
  # extracted and re-printed last.  We assume that the Copyright notice
  # will be separated from the last ChangeLog entry by one or more
  # blank lines and the Copyright notice starts on the 1st column.
  if (defined($cur_entry) && $cur_entry =~ /^[0-9].*([\r\n]{2}\S.*?)$/s)
  {
    debug "Copyright notice in `$f'? <<<$1>>>";
    if (defined $copyright_notice)
    {
      error("$0: Copyright notices in `$copyright_notice_file'"
            . " and `$f' differ.\n")
        if ($copyright_notice ne $1);
    }
    else
    {
      $copyright_notice = $1;
      $copyright_notice_file = $f;
    }
    $cur_entry = substr($cur_entry, 0, length($1));
  }
  else
  {
    debug "No Copyright notice in `$f'";
  }

  add_entry($cur_date, $cur_entry);
}

# ---------------------- #
# Rebuild the ChangeLog. #
# ---------------------- #

use IO::Handle;
use IO::File;

my $out;
if ($output eq '-')
{
  $out = new IO::Handle;
  $out->fdopen(fileno(STDOUT), "w")
    or die("Error while openning stdout: $!");
}
else
{
  $out = new IO::File($output, '>')
    or die("Could not open '$output' for writing: $!");
}
foreach my $k (sort { $b cmp $a } keys %entries)
{
  foreach my $i (@{$entries{$k}})
  {
    print $out $i;
  }
}

# If we have a Copyright notice, make sure it is terminated by a \n and
# print it.
if (defined $copyright_notice)
{
  # Remove all the new lines at the beginning for the Copyright notice.
  $copyright_notice =~ s/^[\r\n]+//;
  # Ensure there is a trailing new line.
  $copyright_notice =~ s/[^\r\n]$/$&\n/;
  print $out $copyright_notice;
}
$out->close() or die("Error while closing '$output': $!");

debug "exit $res";
exit $res;

## Local Variables:
## eval: (add-hook 'write-file-hooks 'time-stamp)
## time-stamp-start: "$VERSION = '"
## time-stamp-format: "%:y-%02m-%02d %02H:%02M"
## time-stamp-time-zone: "UTC"
## time-stamp-end: "'; # UTC"
## End:

--Apple-Mail-19-941398214
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



--Apple-Mail-19-941398214--

--Apple-Mail-20-941398284
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHCi4HwwE67wC8PUkRAtMQAKC2By5XwwYQVcMC9nrUTceggfDPjwCfblsk
apeCHZ2t2tFYipVkzczgw6U=
=T+oI
-----END PGP SIGNATURE-----

--Apple-Mail-20-941398284--
