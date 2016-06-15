From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] Introducing git-cvsserver -- a CVS emulator for git.
Date: Wed, 22 Feb 2006 22:50:15 +1300
Message-ID: <11406018152551-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Feb 22 10:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBqdn-0007y5-Oo
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 10:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWBVJu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 04:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWBVJu1
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 04:50:27 -0500
Received: from bm-2a.paradise.net.nz ([203.96.152.181]:16303 "EHLO
	linda-2.paradise.net.nz") by vger.kernel.org with ESMTP
	id S932568AbWBVJu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 04:50:26 -0500
Received: from smtp-1.paradise.net.nz
 (tclsnelb1-src-1.paradise.net.nz [203.96.152.172]) by linda-2.paradise.net.nz
 (Paradise.net.nz) with ESMTP id <0IV300F2Z1ZX9A@linda-2.paradise.net.nz> for
 git@vger.kernel.org; Wed, 22 Feb 2006 22:50:23 +1300 (NZDT)
Received: from aporo.local (202-0-36-112.cable.paradise.net.nz [202.0.36.112])
	by smtp-1.paradise.net.nz (Postfix) with SMTP id 7CBD1628334; Wed,
 22 Feb 2006 22:50:15 +1300 (NZDT)
In-reply-to: 
To: git@vger.kernel.org
X-Mailer: git-send-email
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16594>

git-cvsserver is highly functional. However, not all methods are implemented,
and for those methods that are implemented, not all switches are implemented.
All the common read operations are implemented, and add/remove/commit are
supported.

Testing has been done using both the CLI CVS client, and the Eclipse CVS
plugin. Most functionality works fine with both of these clients.

Currently git-cvsserver only works over SSH connections, see the
Documentation for more details on how to configure your client. It
does not support pserver for anonymous access but it should not be
hard to implement. Anonymous access will need tighter input validation.

In our very informal tests, it seems to be significantly faster than a real
CVS server.

This utility depends on a version of git-cvsannotate that supports -S and on
DBD::SQLite.

Licensed under GPLv2. Copyright The Open University UK.
Authors: Martyn Smith <martyn@catalyst.net.nz>
         Martin Langhoff <martin@catalyst.net.nz>

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 Documentation/git-cvsserver.txt |   89 +
 Makefile                        |    2 
 git-cvsserver.perl              | 2449 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 2539 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-cvsserver.txt
 create mode 100755 git-cvsserver.perl

1ceecd39c82c5bd469bfebc9744f8ef6dbafc7d6
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
new file mode 100644
index 0000000..f8b52f8
--- /dev/null
+++ b/Documentation/git-cvsserver.txt
@@ -0,0 +1,89 @@
+git-cvsserver(1)
+================
+
+NAME
+----
+git-cvsserver - A CVS server emulator for git
+
+
+SYNOPSIS
+--------
+[verse]
+export CVS_SERVER=git-cvsserver
+'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>
+
+
+DESCRIPTION
+-----------
+
+This application is a CVS emulation layer for git.
+
+It is highly functional. However, not all methods are implemented, 
+and for those methods that are implemented,
+not all switches are implemented.  
+
+Testing has been done using both the CLI CVS client, and the Eclipse CVS
+plugin. Most functionality works fine with both of these clients.
+
+LIMITATIONS
+-----------
+Currently gitcvs only works over ssh connections.
+
+
+INSTALLATION
+------------
+1. Put server.pl somewhere useful on the same machine that is hosting your git repos
+
+2. For each repo that you want accessible from CVS you need to edit config in
+   the repo and add the following section.
+
+   [gitcvs]
+        enabled=1
+        logfile=/path/to/logfile
+
+   n.b. you need to ensure each user that is going to invoke server.pl has
+   write access to the log file.
+
+5. On each client machine you need to set the following variables.
+     CVSROOT should be set as per normal, but the directory should point at the
+             appropriate git repo.
+     CVS_SERVER should be set to the server.pl script that has been put on the
+                remote machine.
+
+6. Clients should now be able to check out modules (where modules are the names
+   of branches in git).
+     $ cvs co -d mylocaldir master
+
+Operations supported
+--------------------
+
+All the operations required for normal use are supported, including
+checkout, diff, status, update, log, add, remove, commit.
+Legacy monitoring operations are not supported (edit, watch and related). 
+Exports and tagging (tags and branches) are not supported at this stage. 
+
+The server will set the -k mode to binary when relevant. In proper GIT
+tradition, the contents of the files are always respected. 
+No keyword expansion or newline munging is supported. 
+
+Dependencies
+------------
+
+git-cvsserver depends on DBD::SQLite. 
+
+Copyright and Authors
+---------------------
+
+This program is copyright The Open University UK - 2006.
+
+Authors: Martyn Smith    <martyn@catalyst.net.nz>
+         Martin Langhoff <martin@catalyst.net.nz>
+         with ideas and patches from participants of the git-list <git@vger.kernel.org>.
+
+Documentation
+--------------
+Documentation by Martyn Smith <martyn@catalyst.net.nz> and Martin Langhoff <martin@catalyst.net.nz>Matthias Urlichs <smurf@smurf.noris.de>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index d8f7d03..bf2436a 100644
--- a/Makefile
+++ b/Makefile
@@ -130,7 +130,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-shortlog.perl git-fmt-merge-msg.perl git-rerere.perl \
-	git-annotate.perl \
+	git-annotate.perl git-cvsserver.perl \
 	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl
 
 SCRIPT_PYTHON = \
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
new file mode 100755
index 0000000..a32cd9a
--- /dev/null
+++ b/git-cvsserver.perl
@@ -0,0 +1,2449 @@
+#!/usr/bin/perl
+
+####
+#### This application is a CVS emulation layer for git.
+#### It is intended for clients to connect over SSH.
+#### See the documentation for more details. 
+####
+#### Copyright The Open University UK - 2006.
+####
+#### Authors: Martyn Smith    <martyn@catalyst.net.nz>
+####          Martin Langhoff <martin@catalyst.net.nz>
+####
+####
+#### Released under the GNU Public License, version 2.
+####
+####
+
+use strict;
+use warnings;
+
+use Fcntl;
+use File::Temp qw/tempdir tempfile/;
+use File::Basename;
+
+my $log = GITCVS::log->new();
+my $cfg;
+
+my $DATE_LIST = {
+    Jan => "01",
+    Feb => "02",
+    Mar => "03",
+    Apr => "04",
+    May => "05",
+    Jun => "06",
+    Jul => "07",
+    Aug => "08",
+    Sep => "09",
+    Oct => "10",
+    Nov => "11",
+    Dec => "12",
+};
+
+# Enable autoflush for STDOUT (otherwise the whole thing falls apart)
+$| = 1;
+
+#### Definition and mappings of functions ####
+
+my $methods = {
+    'Root'            => \&req_Root,
+    'Valid-responses' => \&req_Validresponses,
+    'valid-requests'  => \&req_validrequests,
+    'Directory'       => \&req_Directory,
+    'Entry'           => \&req_Entry,
+    'Modified'        => \&req_Modified,
+    'Unchanged'       => \&req_Unchanged,
+    'Argument'        => \&req_Argument,
+    'Argumentx'       => \&req_Argument,
+    'expand-modules'  => \&req_expandmodules,
+    'add'             => \&req_add,
+    'remove'          => \&req_remove,
+    'co'              => \&req_co,
+    'update'          => \&req_update,
+    'ci'              => \&req_ci,
+    'diff'            => \&req_diff,
+    'log'             => \&req_log,
+    'tag'             => \&req_CATCHALL,
+    'status'          => \&req_status,
+    'admin'           => \&req_CATCHALL,
+    'history'         => \&req_CATCHALL,
+    'watchers'        => \&req_CATCHALL,
+    'editors'         => \&req_CATCHALL,
+    'annotate'        => \&req_annotate,
+    'Global_option'   => \&req_Globaloption,
+    #'annotate'        => \&req_CATCHALL,
+};
+
+##############################################
+
+
+# $state holds all the bits of information the clients sends us that could
+# potentially be useful when it comes to actually _doing_ something.
+my $state = {};
+$log->info("--------------- STARTING -----------------");
+
+my $TEMP_DIR = tempdir( CLEANUP => 1 );
+$log->debug("Temporary directory is '$TEMP_DIR'");
+
+# Keep going until the client closes the connection
+while (<STDIN>)
+{
+    chomp;
+
+    # Check to see if we've seen this method, and call appropiate function.
+    if ( /^([\w-]+)(?:\s+(.*))?$/ and defined($methods->{$1}) )
+    {
+        # use the $methods hash to call the appropriate sub for this command
+        #$log->info("Method : $1");
+        &{$methods->{$1}}($1,$2);
+    } else {
+        # log fatal because we don't understand this function. If this happens
+        # we're fairly screwed because we don't know if the client is expecting
+        # a response. If it is, the client will hang, we'll hang, and the whole
+        # thing will be custard.
+        $log->fatal("Don't understand command $_\n");
+        die("Unknown command $_");
+    }
+}
+
+$log->debug("Processing time : user=" . (times)[0] . " system=" . (times)[1]);
+$log->info("--------------- FINISH -----------------");
+
+# Magic catchall method.
+#    This is the method that will handle all commands we haven't yet
+#    implemented. It simply sends a warning to the log file indicating a
+#    command that hasn't been implemented has been invoked.
+sub req_CATCHALL
+{
+    my ( $cmd, $data ) = @_;
+    $log->warn("Unhandled command : req_$cmd : $data");
+}
+
+
+# Root pathname \n 
+#     Response expected: no. Tell the server which CVSROOT to use. Note that
+#     pathname is a local directory and not a fully qualified CVSROOT variable.
+#     pathname must already exist; if creating a new root, use the init
+#     request, not Root. pathname does not include the hostname of the server,
+#     how to access the server, etc.; by the time the CVS protocol is in use,
+#     connection, authentication, etc., are already taken care of. The Root
+#     request must be sent only once, and it must be sent before any requests
+#     other than Valid-responses, valid-requests, UseUnchanged, Set or init.
+sub req_Root
+{
+    my ( $cmd, $data ) = @_;
+    $log->debug("req_Root : $data");
+
+    $state->{CVSROOT} = $data;
+
+    $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
+
+    foreach my $line ( `git-var -l` )
+    {
+        next unless ( $line =~ /^(.*?)\.(.*?)=(.*)$/ );
+        $cfg->{$1}{$2} = $3;
+    }
+
+    unless ( defined ( $cfg->{gitcvs}{enabled} ) and $cfg->{gitcvs}{enabled} =~ /^\s*(1|true|yes)\s*$/i )
+    {
+        print "E GITCVS emulation needs to be enabled on this repo\n";
+        print "E the repo config file needs a [gitcvs] section added, and the parameter 'enabled' set to 1\n";
+        print "E \n";
+        print "error 1 GITCVS emulation disabled\n";
+    }
+
+    if ( defined ( $cfg->{gitcvs}{logfile} ) )
+    {
+        $log->setfile($cfg->{gitcvs}{logfile});
+    } else {
+        $log->nofile();
+    }
+}
+
+# Global_option option \n 
+#     Response expected: no. Transmit one of the global options `-q', `-Q',
+#     `-l', `-t', `-r', or `-n'. option must be one of those strings, no
+#     variations (such as combining of options) are allowed. For graceful
+#     handling of valid-requests, it is probably better to make new global
+#     options separate requests, rather than trying to add them to this
+#     request.
+sub req_Globaloption
+{
+    my ( $cmd, $data ) = @_;
+    $log->debug("req_Globaloption : $data");
+
+    # TODO : is this data useful ???
+}
+
+# Valid-responses request-list \n 
+#     Response expected: no. Tell the server what responses the client will
+#     accept. request-list is a space separated list of tokens.
+sub req_Validresponses
+{
+    my ( $cmd, $data ) = @_;
+    $log->debug("req_Validrepsonses : $data");
+
+    # TODO : re-enable this, currently it's not particularly useful
+    #$state->{validresponses} = [ split /\s+/, $data ];
+}
+
+# valid-requests \n 
+#     Response expected: yes. Ask the server to send back a Valid-requests
+#     response.
+sub req_validrequests
+{
+    my ( $cmd, $data ) = @_;
+
+    $log->debug("req_validrequests");
+    
+    $log->debug("SEND : Valid-requests " . join(" ",keys %$methods));
+    $log->debug("SEND : ok");
+
+    print "Valid-requests " . join(" ",keys %$methods) . "\n";
+    print "ok\n";
+}
+
+# Directory local-directory \n 
+#     Additional data: repository \n. Response expected: no. Tell the server
+#     what directory to use. The repository should be a directory name from a
+#     previous server response. Note that this both gives a default for Entry
+#     and Modified and also for ci and the other commands; normal usage is to
+#     send Directory for each directory in which there will be an Entry or
+#     Modified, and then a final Directory for the original directory, then the
+#     command. The local-directory is relative to the top level at which the
+#     command is occurring (i.e. the last Directory which is sent before the
+#     command); to indicate that top level, `.' should be sent for
+#     local-directory.
+sub req_Directory
+{
+    my ( $cmd, $data ) = @_;
+
+    my $repository = <STDIN>;
+    chomp $repository;
+
+
+    $state->{localdir} = $data;
+    $state->{repository} = $repository;
+    $state->{directory} = $repository;
+    $state->{directory} =~ s/^$state->{CVSROOT}\///;
+    $state->{module} = $1 if ($state->{directory} =~ s/^(.*?)(\/|$)//);
+    $state->{directory} .= "/" if ( $state->{directory} =~ /\S/ );
+
+    $log->debug("req_Directory : localdir=$data repository=$repository directory=$state->{directory} module=$state->{module}");
+}
+
+# Entry entry-line \n 
+#     Response expected: no. Tell the server what version of a file is on the
+#     local machine. The name in entry-line is a name relative to the directory
+#     most recently specified with Directory. If the user is operating on only
+#     some files in a directory, Entry requests for only those files need be
+#     included. If an Entry request is sent without Modified, Is-modified, or
+#     Unchanged, it means the file is lost (does not exist in the working
+#     directory). If both Entry and one of Modified, Is-modified, or Unchanged
+#     are sent for the same file, Entry must be sent first. For a given file,
+#     one can send Modified, Is-modified, or Unchanged, but not more than one
+#     of these three.
+sub req_Entry
+{
+    my ( $cmd, $data ) = @_;
+
+    $log->debug("req_Entry : $data");
+
+    my @data = split(/\//, $data);
+
+    $state->{entries}{$state->{directory}.$data[1]} = {
+        revision    => $data[2],
+        conflict    => $data[3],
+        options     => $data[4],
+        tag_or_date => $data[5],
+    };
+}
+
+# add \n 
+#     Response expected: yes. Add a file or directory. This uses any previous
+#     Argument, Directory, Entry, or Modified requests, if they have been sent.
+#     The last Directory sent specifies the working directory at the time of
+#     the operation. To add a directory, send the directory to be added using
+#     Directory and Argument requests.
+sub req_add
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit("add");
+
+    my $addcount = 0;
+
+    foreach my $filename ( @{$state->{args}} )
+    {
+        $filename = filecleanup($filename);
+
+        unless ( defined ( $state->{entries}{$filename}{modified_filename} ) )
+        {
+            print "E cvs add: nothing known about `$filename'\n";
+            next;
+        }
+        # TODO : check we're not squashing an already existing file
+        if ( defined ( $state->{entries}{$filename}{revision} ) )
+        {
+            print "E cvs add: `$filename' has already been entered\n";
+            next;
+        }
+
+
+        my ( $filepart, $dirpart ) = filenamesplit($filename);
+
+        print "E cvs add: scheduling file `$filename' for addition\n";
+
+        print "Checked-in $dirpart\n";
+        print "$filename\n";
+        print "/$filepart/0///\n";
+
+        $addcount++;
+    }
+
+    if ( $addcount == 1 )
+    {
+        print "E cvs add: use `cvs commit' to add this file permanently\n";
+    }
+    elsif ( $addcount > 1 )
+    {
+        print "E cvs add: use `cvs commit' to add these files permanently\n";
+    }
+
+    print "ok\n";
+}
+
+# remove \n 
+#     Response expected: yes. Remove a file. This uses any previous Argument,
+#     Directory, Entry, or Modified requests, if they have been sent. The last
+#     Directory sent specifies the working directory at the time of the
+#     operation. Note that this request does not actually do anything to the
+#     repository; the only effect of a successful remove request is to supply
+#     the client with a new entries line containing `-' to indicate a removed
+#     file. In fact, the client probably could perform this operation without
+#     contacting the server, although using remove may cause the server to
+#     perform a few more checks. The client sends a subsequent ci request to
+#     actually record the removal in the repository.
+sub req_remove
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit("remove");
+
+    # Grab a handle to the SQLite db and do any necessary updates
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    $updater->update();
+
+    #$log->debug("add state : " . Dumper($state));
+
+    my $rmcount = 0;
+
+    foreach my $filename ( @{$state->{args}} )
+    {
+        $filename = filecleanup($filename);
+
+        if ( defined ( $state->{entries}{$filename}{unchanged} ) or defined ( $state->{entries}{$filename}{modified_filename} ) )
+        {
+            print "E cvs remove: file `$filename' still in working directory\n";
+            next;
+        }
+
+        my $meta = $updater->getmeta($filename);
+        my $wrev = revparse($filename);
+
+        unless ( defined ( $wrev ) )
+        {
+            print "E cvs remove: nothing known about `$filename'\n";
+            next;
+        }
+
+        if ( defined($wrev) and $wrev < 0 )
+        {
+            print "E cvs remove: file `$filename' already scheduled for removal\n";
+            next;
+        }
+
+        unless ( $wrev == $meta->{revision} )
+        {
+            # TODO : not sure if the format of this message is quite correct.
+            print "E cvs remove: Up to date check failed for `$filename'\n";
+            next;
+        }
+
+
+        my ( $filepart, $dirpart ) = filenamesplit($filename);
+
+        print "E cvs remove: scheduling `$filename' for removal\n";
+
+        print "Checked-in $dirpart\n";
+        print "$filename\n";
+        print "/$filepart/-1.$wrev///\n";
+
+        $rmcount++;
+    }
+
+    if ( $rmcount == 1 )
+    {
+        print "E cvs remove: use `cvs commit' to remove this file permanently\n";
+    }
+    elsif ( $rmcount > 1 )
+    {
+        print "E cvs remove: use `cvs commit' to remove these files permanently\n";
+    }
+
+    print "ok\n";
+}
+
+# Modified filename \n 
+#     Response expected: no. Additional data: mode, \n, file transmission. Send
+#     the server a copy of one locally modified file. filename is a file within
+#     the most recent directory sent with Directory; it must not contain `/'.
+#     If the user is operating on only some files in a directory, only those
+#     files need to be included. This can also be sent without Entry, if there
+#     is no entry for the file.
+sub req_Modified
+{
+    my ( $cmd, $data ) = @_;
+
+    my $mode = <STDIN>;
+    chomp $mode;
+    my $size = <STDIN>;
+    chomp $size;
+
+    # Grab config information
+    my $blocksize = 8192;
+    my $bytesleft = $size;
+    my $tmp;
+
+    # Get a filehandle/name to write it to
+    my ( $fh, $filename ) = tempfile( DIR => $TEMP_DIR );
+
+    # Loop over file data writing out to temporary file.
+    while ( $bytesleft )
+    {
+        $blocksize = $bytesleft if ( $bytesleft < $blocksize );
+        read STDIN, $tmp, $blocksize;
+        print $fh $tmp;
+        $bytesleft -= $blocksize;
+    }
+
+    close $fh;
+
+    # Ensure we have something sensible for the file mode
+    if ( $mode =~ /u=(\w+)/ )
+    {
+        $mode = $1;
+    } else {
+        $mode = "rw";
+    }
+
+    # Save the file data in $state
+    $state->{entries}{$state->{directory}.$data}{modified_filename} = $filename;
+    $state->{entries}{$state->{directory}.$data}{modified_mode} = $mode;
+    $state->{entries}{$state->{directory}.$data}{modified_hash} = `git-hash-object $filename`;
+    $state->{entries}{$state->{directory}.$data}{modified_hash} =~ s/\s.*$//s;
+
+    #$log->debug("req_Modified : file=$data mode=$mode size=$size");
+}
+
+# Unchanged filename \n 
+#     Response expected: no. Tell the server that filename has not been
+#     modified in the checked out directory. The filename is a file within the
+#     most recent directory sent with Directory; it must not contain `/'.
+sub req_Unchanged
+{
+    my ( $cmd, $data ) = @_;
+
+    $state->{entries}{$state->{directory}.$data}{unchanged} = 1;
+
+    #$log->debug("req_Unchanged : $data");
+}
+
+# Argument text \n 
+#     Response expected: no. Save argument for use in a subsequent command.
+#     Arguments accumulate until an argument-using command is given, at which
+#     point they are forgotten.
+# Argumentx text \n 
+#     Response expected: no. Append \n followed by text to the current argument
+#     being saved.
+sub req_Argument
+{
+    my ( $cmd, $data ) = @_;
+
+    # TODO :  Not quite sure how Argument and Argumentx differ, but I assume
+    # it's for multi-line arguments ... somehow ...
+
+    $log->debug("$cmd : $data");
+
+    push @{$state->{arguments}}, $data;
+}
+
+# expand-modules \n 
+#     Response expected: yes. Expand the modules which are specified in the
+#     arguments. Returns the data in Module-expansion responses. Note that the
+#     server can assume that this is checkout or export, not rtag or rdiff; the
+#     latter do not access the working directory and thus have no need to
+#     expand modules on the client side. Expand may not be the best word for
+#     what this request does. It does not necessarily tell you all the files
+#     contained in a module, for example. Basically it is a way of telling you
+#     which working directories the server needs to know about in order to
+#     handle a checkout of the specified modules. For example, suppose that the
+#     server has a module defined by 
+#   aliasmodule -a 1dir
+#     That is, one can check out aliasmodule and it will take 1dir in the
+#     repository and check it out to 1dir in the working directory. Now suppose
+#     the client already has this module checked out and is planning on using
+#     the co request to update it. Without using expand-modules, the client
+#     would have two bad choices: it could either send information about all
+#     working directories under the current directory, which could be
+#     unnecessarily slow, or it could be ignorant of the fact that aliasmodule
+#     stands for 1dir, and neglect to send information for 1dir, which would
+#     lead to incorrect operation. With expand-modules, the client would first
+#     ask for the module to be expanded:
+sub req_expandmodules
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit();
+
+    $log->debug("req_expandmodules : " . ( defined($data) ? $data : "[NULL]" ) );
+
+    unless ( ref $state->{arguments} eq "ARRAY" )
+    {
+        print "ok\n";
+        return;
+    }
+
+    foreach my $module ( @{$state->{arguments}} )
+    {
+        $log->debug("SEND : Module-expansion $module");
+        print "Module-expansion $module\n";
+    }
+
+    print "ok\n";
+    statecleanup();
+}
+
+# co \n 
+#     Response expected: yes. Get files from the repository. This uses any
+#     previous Argument, Directory, Entry, or Modified requests, if they have
+#     been sent. Arguments to this command are module names; the client cannot
+#     know what directories they correspond to except by (1) just sending the
+#     co request, and then seeing what directory names the server sends back in
+#     its responses, and (2) the expand-modules request.
+sub req_co
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit("co");
+
+    my $module = $state->{args}[0];
+    my $checkout_path = $module;
+
+    # use the user specified directory if we're given it
+    $checkout_path = $state->{opt}{d} if ( exists ( $state->{opt}{d} ) );
+
+    $log->debug("req_co : " . ( defined($data) ? $data : "[NULL]" ) );
+
+    $log->info("Checking out module '$module' ($state->{CVSROOT}) to '$checkout_path'");
+
+    $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
+
+    # Grab a handle to the SQLite db and do any necessary updates
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $module, $log);
+    $updater->update();
+
+    # instruct the client that we're checking out to $checkout_path
+    print "E cvs server: updating $checkout_path\n";
+
+    foreach my $git ( @{$updater->gethead} )
+    {
+        # Don't want to check out deleted files
+        next if ( $git->{filehash} eq "deleted" );
+
+        ( $git->{name}, $git->{dir} ) = filenamesplit($git->{name});
+
+        # modification time of this file
+        print "Mod-time $git->{modified}\n";
+
+        # print some information to the client
+        print "MT +updated\n";
+        print "MT text U\n";
+        if ( defined ( $git->{dir} ) and $git->{dir} ne "./" )
+        {
+            print "MT fname $checkout_path/$git->{dir}$git->{name}\n";
+        } else {
+            print "MT fname $checkout_path/$git->{name}\n";
+        }
+        print "MT newline\n";
+        print "MT -updated\n";
+
+        # instruct client we're sending a file to put in this path
+        print "Created $checkout_path/" . ( defined ( $git->{dir} ) ? $git->{dir} . "/" : "" ) . "\n";
+
+        print $state->{CVSROOT} . "/$module/" . ( defined ( $git->{dir} ) ? $git->{dir} . "/" : "" ) . "$git->{name}\n";
+
+        # this is an "entries" line
+        print "/$git->{name}/1.$git->{revision}///\n";
+        # permissions
+        print "u=$git->{mode},g=$git->{mode},o=$git->{mode}\n";
+
+        # transmit file
+        transmitfile($git->{filehash});
+    }
+
+    print "ok\n";
+
+    statecleanup();
+}
+
+# update \n 
+#     Response expected: yes. Actually do a cvs update command. This uses any
+#     previous Argument, Directory, Entry, or Modified requests, if they have
+#     been sent. The last Directory sent specifies the working directory at the
+#     time of the operation. The -I option is not used--files which the client
+#     can decide whether to ignore are not mentioned and the client sends the
+#     Questionable request for others.
+sub req_update
+{
+    my ( $cmd, $data ) = @_;
+
+    $log->debug("req_update : " . ( defined($data) ? $data : "[NULL]" ));
+
+    argsplit("update");
+
+    # Grab a handle to the SQLite db and do any necessary updates
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+
+    $updater->update();
+
+    # if no files were specified, we need to work out what files we should be providing status on ...
+    argsfromdir($updater) if ( scalar ( @{$state->{args}} ) == 0 );
+
+    #$log->debug("update state : " . Dumper($state));
+
+    # foreach file specified on the commandline ...
+    foreach my $filename ( @{$state->{args}} )
+    {
+        $filename = filecleanup($filename);
+
+        # if we have a -C we should pretend we never saw modified stuff
+        if ( exists ( $state->{opt}{C} ) )
+        {
+            delete $state->{entries}{$filename}{modified_hash};
+            delete $state->{entries}{$filename}{modified_filename};
+            $state->{entries}{$filename}{unchanged} = 1;
+        }
+
+        my $meta;
+        if ( defined($state->{opt}{r}) and $state->{opt}{r} =~ /^1\.(\d+)/ )
+        {
+            $meta = $updater->getmeta($filename, $1);
+        } else {
+            $meta = $updater->getmeta($filename);
+        }
+
+        next unless ( $meta->{revision} );
+
+        my $oldmeta = $meta;
+
+        my $wrev = revparse($filename);
+
+        # If the working copy is an old revision, lets get that version too for comparison.
+        if ( defined($wrev) and $wrev != $meta->{revision} )
+        {
+            $oldmeta = $updater->getmeta($filename, $wrev);
+        }
+
+        #$log->debug("Target revision is $meta->{revision}, current working revision is $wrev");
+
+        # Files are up to date if the working copy and repo copy have the same revision, and the working copy is unmodified _and_ the user hasn't specified -C
+        next if ( defined ( $wrev ) and defined($meta->{revision}) and $wrev == $meta->{revision} and $state->{entries}{$filename}{unchanged} and not exists ( $state->{opt}{C} ) );
+
+        if ( $meta->{filehash} eq "deleted" )
+        {
+            my ( $filepart, $dirpart ) = filenamesplit($filename);
+
+            $log->info("Removing '$filename' from working copy (no longer in the repo)");
+
+            print "E cvs update: `$filename' is no longer in the repository\n";
+            print "Removed $dirpart\n";
+            print "$filepart\n";
+        }
+        elsif ( not defined ( $state->{entries}{$filename}{modified_hash} ) or $state->{entries}{$filename}{modified_hash} eq $oldmeta->{filehash} )
+        {
+            $log->info("Updating '$filename'");
+            # normal update, just send the new revision (either U=Update, or A=Add, or R=Remove)
+            print "MT +updated\n";
+            print "MT text U\n";
+            print "MT fname $filename\n";
+            print "MT newline\n";
+            print "MT -updated\n";
+
+            my ( $filepart, $dirpart ) = filenamesplit($filename);
+            $dirpart =~ s/^$state->{directory}//;
+
+            if ( defined ( $wrev ) )
+            {
+                # instruct client we're sending a file to put in this path as a replacement
+                print "Update-existing $dirpart\n";
+                $log->debug("Updating existing file 'Update-existing $dirpart'");
+            } else {
+                # instruct client we're sending a file to put in this path as a new file
+                print "Created $dirpart\n";
+                $log->debug("Creating new file 'Created $dirpart'");
+            }
+            print $state->{CVSROOT} . "/$state->{module}/$filename\n";
+
+            # this is an "entries" line
+            $log->debug("/$filepart/1.$meta->{revision}///");
+            print "/$filepart/1.$meta->{revision}///\n";
+
+            # permissions
+            $log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
+            print "u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}\n";
+
+            # transmit file
+            transmitfile($meta->{filehash});
+        } else {
+            my ( $filepart, $dirpart ) = filenamesplit($meta->{name});
+
+            my $dir = tempdir( DIR => $TEMP_DIR, CLEANUP => 1 ) . "/";
+
+            chdir $dir;
+            my $file_local = $filepart . ".mine";
+            system("ln","-s",$state->{entries}{$filename}{modified_filename}, $file_local);
+            my $file_old = $filepart . "." . $oldmeta->{revision};
+            transmitfile($oldmeta->{filehash}, $file_old);
+            my $file_new = $filepart . "." . $meta->{revision};
+            transmitfile($meta->{filehash}, $file_new);
+
+            # we need to merge with the local changes ( M=successful merge, C=conflict merge )
+            $log->info("Merging $file_local, $file_old, $file_new");
+
+            $log->debug("Temporary directory for merge is $dir");
+
+            my $return = system("merge", $file_local, $file_old, $file_new);
+            $return >>= 8;
+
+            if ( $return == 0 )
+            {
+                $log->info("Merged successfully");
+                print "M M $filename\n";
+                $log->debug("Update-existing $dirpart");
+                print "Update-existing $dirpart\n";
+                $log->debug($state->{CVSROOT} . "/$state->{module}/$filename");
+                print $state->{CVSROOT} . "/$state->{module}/$filename\n";
+                $log->debug("/$filepart/1.$meta->{revision}///");
+                print "/$filepart/1.$meta->{revision}///\n";
+            }
+            elsif ( $return == 1 )
+            {
+                $log->info("Merged with conflicts");
+                print "M C $filename\n";
+                print "Update-existing $dirpart\n";
+                print $state->{CVSROOT} . "/$state->{module}/$filename\n";
+                print "/$filepart/1.$meta->{revision}/+//\n";
+            }
+            else
+            {
+                $log->warn("Merge failed");
+                next;
+            }
+
+            # permissions
+            $log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
+            print "u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}\n";
+
+            # transmit file, format is single integer on a line by itself (file
+            # size) followed by the file contents
+            # TODO : we should copy files in blocks
+            my $data = `cat $file_local`;
+            $log->debug("File size : " . length($data));
+            print length($data) . "\n";
+            print $data;
+
+            chdir "/";
+        }
+
+    }
+
+    print "ok\n";
+}
+
+sub req_ci
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit("ci");
+
+    #$log->debug("State : " . Dumper($state));
+
+    $log->info("req_ci : " . ( defined($data) ? $data : "[NULL]" ));
+
+    if ( -e $state->{CVSROOT} . "/index" )
+    {
+        print "error 1 Index already exists in git repo\n";
+        exit;
+    }
+
+    my $lockfile = "$state->{CVSROOT}/refs/heads/$state->{module}.lock";
+    unless ( sysopen(LOCKFILE,$lockfile,O_EXCL|O_CREAT|O_WRONLY) )
+    {
+        print "error 1 Lock file '$lockfile' already exists, please try again\n";
+        exit;
+    }
+
+    # Grab a handle to the SQLite db and do any necessary updates
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    $updater->update();
+
+    my $tmpdir = tempdir ( DIR => $TEMP_DIR );
+    my ( undef, $file_index ) = tempfile ( DIR => $TEMP_DIR, OPEN => 0 );
+    $log->info("Lock successful, basing commit on '$tmpdir', index file is '$file_index'");
+
+    $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
+    $ENV{GIT_INDEX_FILE} = $file_index;
+
+    chdir $tmpdir;
+
+    # populate the temporary index based
+    system("git-read-tree", $state->{module});
+    unless ($? == 0)
+    {
+	die "Error running git-read-tree $state->{module} $file_index $!";
+    }
+    $log->info("Created index '$file_index' with for head $state->{module} - exit status $?");
+
+
+    my @committedfiles = ();
+
+    # foreach file specified on the commandline ...
+    foreach my $filename ( @{$state->{args}} )
+    {
+        $filename = filecleanup($filename);
+
+        next unless ( exists $state->{entries}{$filename}{modified_filename} or not $state->{entries}{$filename}{unchanged} );
+
+        my $meta = $updater->getmeta($filename);
+
+        my $wrev = revparse($filename);
+
+        my ( $filepart, $dirpart ) = filenamesplit($filename);
+
+        # do a checkout of the file if it part of this tree
+        if ($wrev) {
+            system('git-checkout-index', '-f', '-u', $filename);
+            unless ($? == 0) {
+                die "Error running git-checkout-index -f -u $filename : $!";
+            }
+        }
+
+        my $addflag = 0;
+        my $rmflag = 0;
+        $rmflag = 1 if ( defined($wrev) and $wrev < 0 );
+        $addflag = 1 unless ( -e $filename );
+
+        # Do up to date checking
+        unless ( $addflag or $wrev == $meta->{revision} or ( $rmflag and -$wrev == $meta->{revision} ) )
+        {
+            # fail everything if an up to date check fails
+            print "error 1 Up to date check failed for $filename\n";
+            close LOCKFILE;
+            unlink($lockfile);
+            chdir "/";
+            exit;
+        }
+
+        push @committedfiles, $filename;
+        $log->info("Committing $filename");
+
+        system("mkdir","-p",$dirpart) unless ( -d $dirpart );
+
+        unless ( $rmflag )
+        {
+            $log->debug("rename $state->{entries}{$filename}{modified_filename} $filename");
+            rename $state->{entries}{$filename}{modified_filename},$filename;
+
+            # Calculate modes to remove
+            my $invmode = "";
+            foreach ( qw (r w x) ) { $invmode .= $_ unless ( $state->{entries}{$filename}{modified_mode} =~ /$_/ ); }
+
+            $log->debug("chmod u+" . $state->{entries}{$filename}{modified_mode} . "-" . $invmode . " $filename");
+            system("chmod","u+" .  $state->{entries}{$filename}{modified_mode} . "-" . $invmode, $filename);
+        }
+
+        if ( $rmflag )
+        {
+            $log->info("Removing file '$filename'");
+            unlink($filename);
+            system("git-update-index", "--remove", $filename);
+        }
+        elsif ( $addflag )
+        {
+            $log->info("Adding file '$filename'");
+            system("git-update-index", "--add", $filename);
+        } else {
+            $log->info("Updating file '$filename'");
+            system("git-update-index", $filename);
+        }
+    }
+
+    unless ( scalar(@committedfiles) > 0 )
+    {
+        print "E No files to commit\n";
+        print "ok\n";
+        close LOCKFILE;
+        unlink($lockfile);
+        chdir "/";
+        return;
+    }
+
+    my $treehash = `git-write-tree`;
+    my $parenthash = `cat $ENV{GIT_DIR}refs/heads/$state->{module}`;
+    chomp $treehash;
+    chomp $parenthash;
+
+    $log->debug("Treehash : $treehash, Parenthash : $parenthash");
+
+    # write our commit message out if we have one ...
+    my ( $msg_fh, $msg_filename ) = tempfile( DIR => $TEMP_DIR );
+    print $msg_fh $state->{opt}{m};# if ( exists ( $state->{opt}{m} ) );
+    print $msg_fh "\n\nvia git-CVS emulator\n";
+    close $msg_fh;
+
+    my $commithash = `git-commit-tree $treehash -p $parenthash < $msg_filename`;
+    $log->info("Commit hash : $commithash");
+
+    unless ( $commithash =~ /[a-zA-Z0-9]{40}/ )
+    {
+        $log->warn("Commit failed (Invalid commit hash)");
+        print "error 1 Commit failed (unknown reason)\n";
+        close LOCKFILE;
+        unlink($lockfile);
+        chdir "/";
+        exit;
+    }
+
+    open FILE, ">", "$ENV{GIT_DIR}refs/heads/$state->{module}";
+    print FILE $commithash;
+    close FILE;
+
+    $updater->update();
+
+    # foreach file specified on the commandline ...
+    foreach my $filename ( @committedfiles )
+    {
+        $filename = filecleanup($filename);
+
+        my $meta = $updater->getmeta($filename);
+
+        my ( $filepart, $dirpart ) = filenamesplit($filename);
+
+        $log->debug("Checked-in $dirpart : $filename");
+
+        if ( $meta->{filehash} eq "deleted" )
+        {
+            print "Remove-entry $dirpart\n";
+            print "$filename\n";
+        } else {
+            print "Checked-in $dirpart\n";
+            print "$filename\n";
+            print "/$filepart/1.$meta->{revision}///\n";
+        }
+    }
+
+    close LOCKFILE;
+    unlink($lockfile);
+    chdir "/";
+
+    print "ok\n";
+}
+
+sub req_status
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit("status");
+
+    $log->info("req_status : " . ( defined($data) ? $data : "[NULL]" ));
+    #$log->debug("status state : " . Dumper($state));
+
+    # Grab a handle to the SQLite db and do any necessary updates
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    $updater->update();
+
+    # if no files were specified, we need to work out what files we should be providing status on ...
+    argsfromdir($updater) if ( scalar ( @{$state->{args}} ) == 0 );
+
+    # foreach file specified on the commandline ...
+    foreach my $filename ( @{$state->{args}} )
+    {
+        $filename = filecleanup($filename);
+
+        my $meta = $updater->getmeta($filename);
+        my $oldmeta = $meta;
+
+        my $wrev = revparse($filename);
+
+        # If the working copy is an old revision, lets get that version too for comparison.
+        if ( defined($wrev) and $wrev != $meta->{revision} )
+        {
+            $oldmeta = $updater->getmeta($filename, $wrev);
+        }
+
+        # TODO : All possible statuses aren't yet implemented
+        my $status;
+        # Files are up to date if the working copy and repo copy have the same revision, and the working copy is unmodified
+        $status = "Up-to-date" if ( defined ( $wrev ) and defined($meta->{revision}) and $wrev == $meta->{revision}
+                                    and
+                                    ( ( $state->{entries}{$filename}{unchanged} and ( not defined ( $state->{entries}{$filename}{conflict} ) or $state->{entries}{$filename}{conflict} !~ /^\+=/ ) )
+                                      or ( defined($state->{entries}{$filename}{modified_hash}) and $state->{entries}{$filename}{modified_hash} eq $meta->{filehash} ) )
+                                   );
+
+        # Need checkout if the working copy has an older revision than the repo copy, and the working copy is unmodified
+        $status ||= "Needs Checkout" if ( defined ( $wrev ) and defined ( $meta->{revision} ) and $meta->{revision} > $wrev
+                                          and
+                                          ( $state->{entries}{$filename}{unchanged}
+                                            or ( defined($state->{entries}{$filename}{modified_hash}) and $state->{entries}{$filename}{modified_hash} eq $oldmeta->{filehash} ) )
+                                        );
+
+        # Need checkout if it exists in the repo but doesn't have a working copy
+        $status ||= "Needs Checkout" if ( not defined ( $wrev ) and defined ( $meta->{revision} ) );
+
+        # Locally modified if working copy and repo copy have the same revision but there are local changes
+        $status ||= "Locally Modified" if ( defined ( $wrev ) and defined($meta->{revision}) and $wrev == $meta->{revision} and $state->{entries}{$filename}{modified_filename} );
+
+        # Needs Merge if working copy revision is less than repo copy and there are local changes
+        $status ||= "Needs Merge" if ( defined ( $wrev ) and defined ( $meta->{revision} ) and $meta->{revision} > $wrev and $state->{entries}{$filename}{modified_filename} );
+
+        $status ||= "Locally Added" if ( defined ( $state->{entries}{$filename}{revision} ) and not defined ( $meta->{revision} ) );
+        $status ||= "Locally Removed" if ( defined ( $wrev ) and defined ( $meta->{revision} ) and -$wrev == $meta->{revision} );
+        $status ||= "Unresolved Conflict" if ( defined ( $state->{entries}{$filename}{conflict} ) and $state->{entries}{$filename}{conflict} =~ /^\+=/ );
+        $status ||= "File had conflicts on merge" if ( 0 );
+
+        $status ||= "Unknown";
+
+        print "M ===================================================================\n";
+        print "M File: $filename\tStatus: $status\n";
+        if ( defined($state->{entries}{$filename}{revision}) )
+        {
+            print "M Working revision:\t" . $state->{entries}{$filename}{revision} . "\n";
+        } else {
+            print "M Working revision:\tNo entry for $filename\n";
+        }
+        if ( defined($meta->{revision}) )
+        {
+            print "M Repository revision:\t1." . $meta->{revision} . "\t$state->{repository}/$filename,v\n";
+            print "M Sticky Tag:\t\t(none)\n";
+            print "M Sticky Date:\t\t(none)\n";
+            print "M Sticky Options:\t\t(none)\n";
+        } else {
+            print "M Repository revision:\tNo revision control file\n";
+        }
+        print "M\n";
+    }
+
+    print "ok\n";
+}
+
+sub req_diff
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit("diff");
+
+    $log->debug("req_diff : " . ( defined($data) ? $data : "[NULL]" ));
+    #$log->debug("status state : " . Dumper($state));
+
+    my ($revision1, $revision2);
+    if ( defined ( $state->{opt}{r} ) and ref $state->{opt}{r} eq "ARRAY" )
+    {
+        $revision1 = $state->{opt}{r}[0];
+        $revision2 = $state->{opt}{r}[1];
+    } else {
+        $revision1 = $state->{opt}{r};
+    }
+
+    $revision1 =~ s/^1\.// if ( defined ( $revision1 ) );
+    $revision2 =~ s/^1\.// if ( defined ( $revision2 ) );
+
+    $log->debug("Diffing revisions " . ( defined($revision1) ? $revision1 : "[NULL]" ) . " and " . ( defined($revision2) ? $revision2 : "[NULL]" ) );
+
+    # Grab a handle to the SQLite db and do any necessary updates
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    $updater->update();
+
+    # if no files were specified, we need to work out what files we should be providing status on ...
+    argsfromdir($updater) if ( scalar ( @{$state->{args}} ) == 0 );
+
+    # foreach file specified on the commandline ...
+    foreach my $filename ( @{$state->{args}} )
+    {
+        $filename = filecleanup($filename);
+
+        my ( $fh, $file1, $file2, $meta1, $meta2, $filediff );
+
+        my $wrev = revparse($filename);
+
+        # We need _something_ to diff against
+        next unless ( defined ( $wrev ) );
+
+        # if we have a -r switch, use it
+        if ( defined ( $revision1 ) )
+        {
+            ( undef, $file1 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
+            $meta1 = $updater->getmeta($filename, $revision1);
+            unless ( defined ( $meta1 ) and $meta1->{filehash} ne "deleted" )
+            {
+                print "E File $filename at revision 1.$revision1 doesn't exist\n";
+                next;
+            }
+            transmitfile($meta1->{filehash}, $file1);
+        }
+        # otherwise we just use the working copy revision
+        else
+        {
+            ( undef, $file1 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
+            $meta1 = $updater->getmeta($filename, $wrev);
+            transmitfile($meta1->{filehash}, $file1);
+        }
+
+        # if we have a second -r switch, use it too
+        if ( defined ( $revision2 ) )
+        {
+            ( undef, $file2 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
+            $meta2 = $updater->getmeta($filename, $revision2);
+
+            unless ( defined ( $meta2 ) and $meta2->{filehash} ne "deleted" )
+            {
+                print "E File $filename at revision 1.$revision2 doesn't exist\n";
+                next;
+            }
+
+            transmitfile($meta2->{filehash}, $file2);
+        }
+        # otherwise we just use the working copy
+        else
+        {
+            $file2 = $state->{entries}{$filename}{modified_filename};
+        }
+
+        # if we have been given -r, and we don't have a $file2 yet, lets get one
+        if ( defined ( $revision1 ) and not defined ( $file2 ) )
+        {
+            ( undef, $file2 ) = tempfile( DIR => $TEMP_DIR, OPEN => 0 );
+            $meta2 = $updater->getmeta($filename, $wrev);
+            transmitfile($meta2->{filehash}, $file2);
+        }
+
+        # We need to have retrieved something useful
+        next unless ( defined ( $meta1 ) );
+
+        # Files to date if the working copy and repo copy have the same revision, and the working copy is unmodified
+        next if ( not defined ( $meta2 ) and $wrev == $meta1->{revision}
+                  and
+                   ( ( $state->{entries}{$filename}{unchanged} and ( not defined ( $state->{entries}{$filename}{conflict} ) or $state->{entries}{$filename}{conflict} !~ /^\+=/ ) )
+                     or ( defined($state->{entries}{$filename}{modified_hash}) and $state->{entries}{$filename}{modified_hash} eq $meta1->{filehash} ) )
+                  );
+
+        # Apparently we only show diffs for locally modified files
+        next unless ( defined($meta2) or defined ( $state->{entries}{$filename}{modified_filename} ) );
+
+        print "M Index: $filename\n";
+        print "M ===================================================================\n";
+        print "M RCS file: $state->{CVSROOT}/$state->{module}/$filename,v\n";
+        print "M retrieving revision 1.$meta1->{revision}\n" if ( defined ( $meta1 ) );
+        print "M retrieving revision 1.$meta2->{revision}\n" if ( defined ( $meta2 ) );
+        print "M diff ";
+        foreach my $opt ( keys %{$state->{opt}} )
+        {
+            if ( ref $state->{opt}{$opt} eq "ARRAY" )
+            {
+                foreach my $value ( @{$state->{opt}{$opt}} )
+                {
+                    print "-$opt $value ";
+                }
+            } else {
+                print "-$opt ";
+                print "$state->{opt}{$opt} " if ( defined ( $state->{opt}{$opt} ) );
+            }
+        }
+        print "$filename\n";
+
+        $log->info("Diffing $filename -r $meta1->{revision} -r " . ( $meta2->{revision} or "workingcopy" ));
+
+        ( $fh, $filediff ) = tempfile ( DIR => $TEMP_DIR );
+
+        if ( exists $state->{opt}{u} )
+        {
+            system("diff -u -L '$filename revision 1.$meta1->{revision}' -L '$filename " . ( defined($meta2->{revision}) ? "revision 1.$meta2->{revision}" : "working copy" ) . "' $file1 $file2 > $filediff");
+        } else {
+            system("diff $file1 $file2 > $filediff");
+        }
+
+        while ( <$fh> )
+        {
+            print "M $_";
+        }
+        close $fh;
+    }
+
+    print "ok\n";
+}
+
+sub req_log
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit("log");
+
+    $log->debug("req_log : " . ( defined($data) ? $data : "[NULL]" ));
+    #$log->debug("log state : " . Dumper($state));
+
+    my ( $minrev, $maxrev );
+    if ( defined ( $state->{opt}{r} ) and $state->{opt}{r} =~ /([\d.]+)?(::?)([\d.]+)?/ )
+    {
+        my $control = $2;
+        $minrev = $1;
+        $maxrev = $3;
+        $minrev =~ s/^1\.// if ( defined ( $minrev ) );
+        $maxrev =~ s/^1\.// if ( defined ( $maxrev ) );
+        $minrev++ if ( defined($minrev) and $control eq "::" );
+    }
+
+    # Grab a handle to the SQLite db and do any necessary updates
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    $updater->update();
+
+    # if no files were specified, we need to work out what files we should be providing status on ...
+    argsfromdir($updater) if ( scalar ( @{$state->{args}} ) == 0 );
+
+    # foreach file specified on the commandline ...
+    foreach my $filename ( @{$state->{args}} )
+    {
+        $filename = filecleanup($filename);
+
+        my $headmeta = $updater->getmeta($filename);
+
+        my $revisions = $updater->getlog($filename);
+        my $totalrevisions = scalar(@$revisions);
+
+        if ( defined ( $minrev ) )
+        {
+            $log->debug("Removing revisions less than $minrev");
+            while ( scalar(@$revisions) > 0 and $revisions->[-1]{revision} < $minrev )
+            {
+                pop @$revisions;
+            }
+        }
+        if ( defined ( $maxrev ) )
+        {
+            $log->debug("Removing revisions greater than $maxrev");
+            while ( scalar(@$revisions) > 0 and $revisions->[0]{revision} > $maxrev )
+            {
+                shift @$revisions;
+            }
+        }
+
+        next unless ( scalar(@$revisions) );
+
+        print "M \n";
+        print "M RCS file: $state->{CVSROOT}/$state->{module}/$filename,v\n";
+        print "M Working file: $filename\n";
+        print "M head: 1.$headmeta->{revision}\n";
+        print "M branch:\n";
+        print "M locks: strict\n";
+        print "M access list:\n";
+        print "M symbolic names:\n";
+        print "M keyword substitution: kv\n";
+        print "M total revisions: $totalrevisions;\tselected revisions: " . scalar(@$revisions) . "\n";
+        print "M description:\n";
+
+        foreach my $revision ( @$revisions )
+        {
+            print "M ----------------------------\n";
+            print "M revision 1.$revision->{revision}\n";
+            # reformat the date for log output
+            $revision->{modified} = sprintf('%04d/%02d/%02d %s', $3, $DATE_LIST->{$2}, $1, $4 ) if ( $revision->{modified} =~ /(\d+)\s+(\w+)\s+(\d+)\s+(\S+)/ and defined($DATE_LIST->{$2}) );
+            $revision->{author} =~ s/\s+.*//;
+            $revision->{author} =~ s/^(.{8}).*/$1/;
+            print "M date: $revision->{modified};  author: $revision->{author};  state: " . ( $revision->{filehash} eq "deleted" ? "dead" : "Exp" ) . ";  lines: +2 -3\n";
+            my $commitmessage = $updater->commitmessage($revision->{commithash});
+            $commitmessage =~ s/^/M /mg;
+            print $commitmessage . "\n";
+        }
+        print "M =============================================================================\n";
+    }
+
+    print "ok\n";
+}
+
+sub req_annotate
+{
+    my ( $cmd, $data ) = @_;
+
+    argsplit("annotate");
+
+    $log->info("req_annotate : " . ( defined($data) ? $data : "[NULL]" ));
+    #$log->debug("status state : " . Dumper($state));
+
+    # Grab a handle to the SQLite db and do any necessary updates
+    my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
+    $updater->update();
+
+    # if no files were specified, we need to work out what files we should be providing annotate on ...
+    argsfromdir($updater) if ( scalar ( @{$state->{args}} ) == 0 );
+
+    # we'll need a temporary checkout dir
+    my $tmpdir = tempdir ( DIR => $TEMP_DIR );
+    my ( undef, $file_index ) = tempfile ( DIR => $TEMP_DIR, OPEN => 0 );
+    $log->info("Temp checkoutdir creation successful, basing annotate session work on '$tmpdir', index file is '$file_index'");
+
+    $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
+    $ENV{GIT_INDEX_FILE} = $file_index;
+
+    chdir $tmpdir;
+
+    # foreach file specified on the commandline ...
+    foreach my $filename ( @{$state->{args}} )
+    {
+        $filename = filecleanup($filename);
+
+        my $meta = $updater->getmeta($filename);
+
+        next unless ( $meta->{revision} );
+
+	# get all the commits that this file was in
+	# in dense format -- aka skip dead revisions
+        my $revisions   = $updater->gethistorydense($filename);
+	my $lastseenin  = $revisions->[0][2];
+
+	# populate the temporary index based on the latest commit were we saw
+	# the file -- but do it cheaply without checking out any files
+	# TODO: if we got a revision from the client, use that instead
+	# to look up the commithash in sqlite (still good to default to 
+	# the current head as we do now)
+	system("git-read-tree", $lastseenin);
+	unless ($? == 0)
+	{
+	    die "Error running git-read-tree $lastseenin $file_index $!";
+	}
+	$log->info("Created index '$file_index' with commit $lastseenin - exit status $?");
+
+        # do a checkout of the file
+        system('git-checkout-index', '-f', '-u', $filename);
+        unless ($? == 0) {
+            die "Error running git-checkout-index -f -u $filename : $!";
+        }
+
+        $log->info("Annotate $filename");
+
+        # Prepare a file with the commits from the linearized
+        # history that annotate should know about. This prevents
+        # git-jsannotate telling us about commits we are hiding
+        # from the client.
+
+        open(ANNOTATEHINTS, ">$tmpdir/.annotate_hints") or die "Error opening > $tmpdir/.annotate_hints $!";
+        for (my $i=0; $i < @$revisions; $i++)
+        {
+            print ANNOTATEHINTS $revisions->[$i][2];
+            if ($i+1 < @$revisions) { # have we got a parent?
+                print ANNOTATEHINTS ' ' . $revisions->[$i+1][2];
+            }
+            print ANNOTATEHINTS "\n";
+        }
+
+        print ANNOTATEHINTS "\n";
+        close ANNOTATEHINTS;
+
+        my $annotatecmd = 'git-annotate';
+        open(ANNOTATE, "-|", $annotatecmd, '-l', '-S', "$tmpdir/.annotate_hints", $filename) 
+	    or die "Error invoking $annotatecmd -l -S $tmpdir/.annotate_hints $filename : $!";
+        my $metadata = {};
+        print "E Annotations for $filename\n";
+        print "E ***************\n";
+        while ( <ANNOTATE> )
+        {
+            if (m/^([a-zA-Z0-9]{40})\t\([^\)]*\)(.*)$/i)
+            {
+                my $commithash = $1;
+                my $data = $2;
+                unless ( defined ( $metadata->{$commithash} ) )
+                {
+                    $metadata->{$commithash} = $updater->getmeta($filename, $commithash);
+                    $metadata->{$commithash}{author} =~ s/\s+.*//;
+                    $metadata->{$commithash}{author} =~ s/^(.{8}).*/$1/;
+                    $metadata->{$commithash}{modified} = sprintf("%02d-%s-%02d", $1, $2, $3) if ( $metadata->{$commithash}{modified} =~ /^(\d+)\s(\w+)\s\d\d(\d\d)/ );
+                }
+                printf("M 1.%-5d      (%-8s %10s): %s\n",
+                    $metadata->{$commithash}{revision},
+                    $metadata->{$commithash}{author},
+                    $metadata->{$commithash}{modified},
+                    $data
+                );
+            } else {
+                $log->warn("Error in annotate output! LINE: $_");
+                print "E Annotate error \n";
+                next;
+            }
+        }
+        close ANNOTATE;
+    }
+
+    # done; get out of the tempdir
+    chdir "/";
+
+    print "ok\n";
+
+}
+
+# This method takes the state->{arguments} array and produces two new arrays.
+# The first is $state->{args} which is everything before the '--' argument, and
+# the second is $state->{files} which is everything after it.
+sub argsplit
+{
+    return unless( defined($state->{arguments}) and ref $state->{arguments} eq "ARRAY" );
+
+    my $type = shift;
+
+    $state->{args} = [];
+    $state->{files} = [];
+    $state->{opt} = {};
+
+    if ( defined($type) )
+    {
+        my $opt = {};
+        $opt = { A => 0, N => 0, P => 0, R => 0, c => 0, f => 0, l => 0, n => 0, p => 0, s => 0, r => 1, D => 1, d => 1, k => 1, j => 1, } if ( $type eq "co" );
+        $opt = { v => 0, l => 0, R => 0 } if ( $type eq "status" );
+        $opt = { A => 0, P => 0, C => 0, d => 0, f => 0, l => 0, R => 0, p => 0, k => 1, r => 1, D => 1, j => 1, I => 1, W => 1 } if ( $type eq "update" );
+        $opt = { l => 0, R => 0, k => 1, D => 1, D => 1, r => 2 } if ( $type eq "diff" );
+        $opt = { c => 0, R => 0, l => 0, f => 0, F => 1, m => 1, r => 1 } if ( $type eq "ci" );
+        $opt = { k => 1, m => 1 } if ( $type eq "add" );
+        $opt = { f => 0, l => 0, R => 0 } if ( $type eq "remove" );
+        $opt = { l => 0, b => 0, h => 0, R => 0, t => 0, N => 0, S => 0, r => 1, d => 1, s => 1, w => 1 } if ( $type eq "log" );
+
+
+        while ( scalar ( @{$state->{arguments}} ) > 0 )
+        {
+            my $arg = shift @{$state->{arguments}};
+
+            next if ( $arg eq "--" );
+            next unless ( $arg =~ /\S/ );
+
+            # if the argument looks like a switch
+            if ( $arg =~ /^-(\w)(.*)/ )
+            {
+                # if it's a switch that takes an argument
+                if ( $opt->{$1} )
+                {
+                    # If this switch has already been provided
+                    if ( $opt->{$1} > 1 and exists ( $state->{opt}{$1} ) )
+                    {
+                        $state->{opt}{$1} = [ $state->{opt}{$1} ];
+                        if ( length($2) > 0 )
+                        {
+                            push @{$state->{opt}{$1}},$2;
+                        } else {
+                            push @{$state->{opt}{$1}}, shift @{$state->{arguments}};
+                        }
+                    } else {
+                        # if there's extra data in the arg, use that as the argument for the switch
+                        if ( length($2) > 0 )
+                        {
+                            $state->{opt}{$1} = $2;
+                        } else {
+                            $state->{opt}{$1} = shift @{$state->{arguments}};
+                        }
+                    }
+                } else {
+                    $state->{opt}{$1} = undef;
+                }
+            }
+            else
+            {
+                push @{$state->{args}}, $arg;
+            }
+        }
+    }
+    else 
+    {
+        my $mode = 0;
+
+        foreach my $value ( @{$state->{arguments}} )
+        {
+            if ( $value eq "--" )
+            {
+                $mode++;
+                next;
+            }
+            push @{$state->{args}}, $value if ( $mode == 0 );
+            push @{$state->{files}}, $value if ( $mode == 1 );
+        }
+    }
+}
+
+# This method uses $state->{directory} to populate $state->{args} with a list of filenames
+sub argsfromdir
+{
+    my $updater = shift;
+
+    $state->{args} = [];
+
+    foreach my $file ( @{$updater->gethead} )
+    {
+        next if ( $file->{filehash} eq "deleted" and not defined ( $state->{entries}{$file->{name}} ) );
+        next unless ( $file->{name} =~ s/^$state->{directory}// );
+        push @{$state->{args}}, $file->{name};
+    }
+}
+
+# This method cleans up the $state variable after a command that uses arguments has run
+sub statecleanup
+{
+    $state->{files} = [];
+    $state->{args} = [];
+    $state->{arguments} = [];
+    $state->{entries} = {};
+}
+
+sub revparse
+{
+    my $filename = shift;
+
+    return undef unless ( defined ( $state->{entries}{$filename}{revision} ) );
+
+    return $1 if ( $state->{entries}{$filename}{revision} =~ /^1\.(\d+)/ );
+    return -$1 if ( $state->{entries}{$filename}{revision} =~ /^-1\.(\d+)/ );
+
+    return undef;
+}
+
+# This method takes a file hash and does a CVS "file transfer" which transmits the
+# size of the file, and then the file contents.
+# If a second argument $targetfile is given, the file is instead written out to
+# a file by the name of $targetfile
+sub transmitfile
+{
+    my $filehash = shift;
+    my $targetfile = shift;
+
+    if ( defined ( $filehash ) and $filehash eq "deleted" )
+    {
+        $log->warn("filehash is 'deleted'");
+        return;
+    }
+
+    die "Need filehash" unless ( defined ( $filehash ) and $filehash =~ /^[a-zA-Z0-9]{40}$/ );
+
+    my $type = `git-cat-file -t $filehash`;
+    chomp $type;
+
+    die ( "Invalid type '$type' (expected 'blob')" ) unless ( defined ( $type ) and $type eq "blob" );
+
+    my $size = `git-cat-file -s $filehash`;
+    chomp $size;
+
+    $log->debug("transmitfile($filehash) size=$size, type=$type");
+
+    if ( open my $fh, '-|', "git-cat-file", "blob", $filehash )
+    {
+        if ( defined ( $targetfile ) )
+        {
+            open NEWFILE, ">", $targetfile or die("Couldn't open '$targetfile' for writing : $!");
+            print NEWFILE $_ while ( <$fh> );
+            close NEWFILE;
+        } else {
+            print "$size\n";
+            print while ( <$fh> );
+        }
+        close $fh or die ("Couldn't close filehandle for transmitfile()");
+    } else {
+        die("Couldn't execute git-cat-file");
+    }
+}
+
+# This method takes a file name, and returns ( $dirpart, $filepart ) which
+# refers to the directory porition and the file portion of the filename
+# respectively
+sub filenamesplit
+{
+    my $filename = shift;
+
+    my ( $filepart, $dirpart ) = ( $filename, "." );
+    ( $filepart, $dirpart ) = ( $2, $1 ) if ( $filename =~ /(.*)\/(.*)/ );
+    $dirpart .= "/";
+
+    return ( $filepart, $dirpart );
+}
+
+sub filecleanup
+{
+    my $filename = shift;
+
+    return undef unless(defined($filename));
+    if ( $filename =~ /^\// )
+    {
+        print "E absolute filenames '$filename' not supported by server\n";
+        return undef;
+    }
+
+    $filename =~ s/^\.\///g;
+    $filename = $state->{directory} . $filename;
+
+    return $filename;
+}
+
+package GITCVS::log;
+
+####
+#### Copyright The Open University UK - 2006.
+####
+#### Authors: Martyn Smith    <martyn@catalyst.net.nz>
+####          Martin Langhoff <martin@catalyst.net.nz>
+####
+####
+
+use strict;
+use warnings;
+
+=head1 NAME
+
+GITCVS::log
+
+=head1 DESCRIPTION
+
+This module provides very crude logging with a similar interface to
+Log::Log4perl
+
+=head1 METHODS
+
+=cut
+
+=head2 new
+
+Creates a new log object, optionally you can specify a filename here to
+indicate the file to log to. If no log file is specified, you can specifiy one
+later with method setfile, or indicate you no longer want logging with method
+nofile.
+
+Until one of these methods is called, all log calls will buffer messages ready
+to write out.
+
+=cut
+sub new
+{
+    my $class = shift;
+    my $filename = shift;
+
+    my $self = {};
+
+    bless $self, $class;
+
+    if ( defined ( $filename ) )
+    {
+        open $self->{fh}, ">>", $filename or die("Couldn't open '$filename' for writing : $!");
+    }
+
+    return $self;
+}
+
+=head2 setfile
+
+This methods takes a filename, and attempts to open that file as the log file.
+If successful, all buffered data is written out to the file, and any further
+logging is written directly to the file.
+
+=cut
+sub setfile
+{
+    my $self = shift;
+    my $filename = shift;
+
+    if ( defined ( $filename ) )
+    {
+        open $self->{fh}, ">>", $filename or die("Couldn't open '$filename' for writing : $!");
+    }
+
+    return unless ( defined ( $self->{buffer} ) and ref $self->{buffer} eq "ARRAY" );
+
+    while ( my $line = shift @{$self->{buffer}} )
+    {
+        print {$self->{fh}} $line;
+    }
+}
+
+=head2 nofile
+
+This method indicates no logging is going to be used. It flushes any entries in
+the internal buffer, and sets a flag to ensure no further data is put there.
+
+=cut
+sub nofile
+{
+    my $self = shift;
+
+    $self->{nolog} = 1;
+
+    return unless ( defined ( $self->{buffer} ) and ref $self->{buffer} eq "ARRAY" );
+
+    $self->{buffer} = [];
+}
+
+=head2 _logopen
+
+Internal method. Returns true if the log file is open, false otherwise.
+
+=cut
+sub _logopen
+{
+    my $self = shift;
+
+    return 1 if ( defined ( $self->{fh} ) and ref $self->{fh} eq "GLOB" );
+    return 0;
+}
+
+=head2 debug info warn fatal
+
+These four methods are wrappers to _log. They provide the actual interface for
+logging data.
+
+=cut
+sub debug { my $self = shift; $self->_log("debug", @_); }
+sub info  { my $self = shift; $self->_log("info" , @_); }
+sub warn  { my $self = shift; $self->_log("warn" , @_); }
+sub fatal { my $self = shift; $self->_log("fatal", @_); }
+
+=head2 _log
+
+This is an internal method called by the logging functions. It generates a
+timestamp and pushes the logged line either to file, or internal buffer.
+
+=cut
+sub _log
+{
+    my $self = shift;
+    my $level = shift;
+
+    return if ( $self->{nolog} );
+
+    my @time = localtime;
+    my $timestring = sprintf("%4d-%02d-%02d %02d:%02d:%02d : %-5s",
+        $time[5] + 1900,
+        $time[4] + 1,
+        $time[3],
+        $time[2],
+        $time[1],
+        $time[0],
+        uc $level,
+    );
+
+    if ( $self->_logopen )
+    {
+        print {$self->{fh}} $timestring . " - " . join(" ",@_) . "\n";
+    } else {
+        push @{$self->{buffer}}, $timestring . " - " . join(" ",@_) . "\n";
+    }
+}
+
+=head2 DESTROY
+
+This method simply closes the file handle if one is open
+
+=cut
+sub DESTROY
+{
+    my $self = shift;
+
+    if ( $self->_logopen )
+    {
+        close $self->{fh};
+    }
+}
+
+package GITCVS::updater;
+
+####
+#### Copyright The Open University UK - 2006.
+####
+#### Authors: Martyn Smith    <martyn@catalyst.net.nz>
+####          Martin Langhoff <martin@catalyst.net.nz>
+####
+####
+
+use strict;
+use warnings;
+use DBI;
+
+=head1 METHODS
+
+=cut
+
+=head2 new
+
+=cut
+sub new
+{
+    my $class = shift;
+    my $config = shift;
+    my $module = shift;
+    my $log = shift;
+
+    die "Need to specify a git repository" unless ( defined($config) and -d $config );
+    die "Need to specify a module" unless ( defined($module) );
+
+    $class = ref($class) || $class;
+
+    my $self = {};
+
+    bless $self, $class;
+
+    $self->{dbdir} = $config . "/";
+    die "Database dir '$self->{dbdir}' isn't a directory" unless ( defined($self->{dbdir}) and -d $self->{dbdir} );
+
+    $self->{module} = $module;
+    $self->{file} = $self->{dbdir} . "/gitcvs.$module.sqlite";
+
+    $self->{git_path} = $config . "/";
+
+    $self->{log} = $log;
+
+    die "Git repo '$self->{git_path}' doesn't exist" unless ( -d $self->{git_path} );
+
+    $self->{dbh} = DBI->connect("dbi:SQLite:dbname=" . $self->{file},"","");
+
+    $self->{tables} = {};
+    foreach my $table ( $self->{dbh}->tables )
+    {
+        $table =~ s/^"//;
+        $table =~ s/"$//;
+        $self->{tables}{$table} = 1;
+    }
+
+    # Construct the revision table if required
+    unless ( $self->{tables}{revision} )
+    {
+        $self->{dbh}->do("
+            CREATE TABLE revision (
+                name       TEXT NOT NULL,
+                revision   INTEGER NOT NULL,
+                filehash   TEXT NOT NULL,
+                commithash TEXT NOT NULL,
+                author     TEXT NOT NULL,
+                modified   TEXT NOT NULL,
+                mode       TEXT NOT NULL
+            )
+        ");
+    }
+
+    # Construct the revision table if required
+    unless ( $self->{tables}{head} )
+    {
+        $self->{dbh}->do("
+            CREATE TABLE head (
+                name       TEXT NOT NULL,
+                revision   INTEGER NOT NULL,
+                filehash   TEXT NOT NULL,
+                commithash TEXT NOT NULL,
+                author     TEXT NOT NULL,
+                modified   TEXT NOT NULL,
+                mode       TEXT NOT NULL
+            )
+        ");
+    }
+
+    # Construct the properties table if required
+    unless ( $self->{tables}{properties} )
+    {
+        $self->{dbh}->do("
+            CREATE TABLE properties (
+                key        TEXT NOT NULL PRIMARY KEY,
+                value      TEXT
+            )
+        ");
+    }
+
+    # Construct the commitmsgs table if required
+    unless ( $self->{tables}{commitmsgs} )
+    {
+        $self->{dbh}->do("
+            CREATE TABLE commitmsgs (
+                key        TEXT NOT NULL PRIMARY KEY,
+                value      TEXT
+            )
+        ");
+    }
+
+    return $self;
+}
+
+=head2 update
+
+=cut
+sub update
+{
+    my $self = shift;
+
+    # first lets get the commit list
+    $ENV{GIT_DIR} = $self->{git_path};
+
+    # prepare database queries
+    my $db_insert_rev = $self->{dbh}->prepare_cached("INSERT INTO revision (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
+    my $db_insert_mergelog = $self->{dbh}->prepare_cached("INSERT INTO commitmsgs (key, value) VALUES (?,?)",{},1);
+    my $db_delete_head = $self->{dbh}->prepare_cached("DELETE FROM head",{},1);
+    my $db_insert_head = $self->{dbh}->prepare_cached("INSERT INTO head (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
+
+    my $commitinfo = `git-cat-file commit $self->{module} 2>&1`;
+    unless ( $commitinfo =~ /tree\s+[a-zA-Z0-9]{40}/ )
+    {
+        die("Invalid module '$self->{module}'");
+    }
+
+
+    my $git_log;
+    my $lastcommit = $self->_get_prop("last_commit");
+
+    # Start exclusive lock here...
+    $self->{dbh}->begin_work() or die "Cannot lock database for BEGIN";
+
+    # TODO: log processing is memory bound
+    # if we can parse into a 2nd file that is in reverse order
+    # we can probably do something really efficient
+    my @git_log_params = ('--parents', '--topo-order'); 
+
+    if (defined $lastcommit) {
+        push @git_log_params, "$lastcommit..$self->{module}";
+    } else {
+        push @git_log_params, $self->{module};
+    }
+    open(GITLOG, '-|', 'git-log', @git_log_params) or die "Cannot call git-log: $!";
+
+    my @commits;
+
+    my %commit = ();
+
+    while ( <GITLOG> )
+    {
+        chomp;
+        if (m/^commit\s+(.*)$/) {
+            # on ^commit lines put the just seen commit in the stack
+            # and prime things for the next one
+            if (keys %commit) {
+                my %copy = %commit;
+                unshift @commits, \%copy;
+                %commit = ();
+            }
+            my @parents = split(m/\s+/, $1);
+            $commit{hash} = shift @parents;
+            $commit{parents} = \@parents;
+        } elsif (m/^(\w+?):\s+(.*)$/ && !exists($commit{message})) {
+            # on rfc822-like lines seen before we see any message,
+            # lowercase the entry and put it in the hash as key-value
+            $commit{lc($1)} = $2;
+        } else {
+            # message lines - skip initial empty line
+            # and trim whitespace
+            if (!exists($commit{message}) && m/^\s*$/) {
+                # define it to mark the end of headers
+                $commit{message} = ''; 
+                next;
+            }
+            s/^\s+//; s/\s+$//; # trim ws
+            $commit{message} .= $_ . "\n";
+        }
+    }
+    close GITLOG;
+
+    unshift @commits, \%commit if ( keys %commit );
+
+    # Now all the commits are in the @commits bucket
+    # ordered by time DESC. for each commit that needs processing,
+    # determine whether it's following the last head we've seen or if
+    # it's on its own branch, grab a file list, and add whatever's changed
+    # NOTE: $lastcommit refers to the last commit from previous run
+    #       $lastpicked is the last commit we picked in this run
+    my $lastpicked;
+    my $head = {};
+    if (defined $lastcommit) {
+        $lastpicked = $lastcommit;
+    }
+
+    my $committotal = scalar(@commits);
+    my $commitcount = 0;
+
+    # Load the head table into $head (for cached lookups during the update process)
+    foreach my $file ( @{$self->gethead()} )
+    {
+        $head->{$file->{name}} = $file;
+    }
+
+    foreach my $commit ( @commits )
+    {
+        $self->{log}->debug("GITCVS::updater - Processing commit $commit->{hash} (" . (++$commitcount) . " of $committotal)");
+        if (defined $lastpicked) 
+        {
+            if (!in_array($lastpicked, @{$commit->{parents}}))
+            {
+                # skip, we'll see this delta 
+                # as part of a merge later
+                # warn "skipping off-track  $commit->{hash}\n";
+                next;
+            } elsif (@{$commit->{parents}} > 1) {
+                # it is a merge commit, for each parent that is
+                # not $lastpicked, see if we can get a log
+                # from the merge-base to that parent to put it
+                # in the message as a merge summary.
+                my @parents = @{$commit->{parents}};
+                foreach my $parent (@parents) {
+                    # git-merge-base can potentially (but rarely) throw
+                    # several candidate merge bases. let's assume
+                    # that the first one is the best one.
+                    if ($parent eq $lastpicked) {
+                        next;
+                    }
+                    open my $p, 'git-merge-base '. $lastpicked . ' '
+                    . $parent . '|';
+                    my @output = (<$p>);
+                    close $p;
+                    my $base = join('', @output);
+                    chomp $base;
+                    if ($base) {
+                        my @merged;
+                        # print "want to log between  $base $parent \n";
+                        open(GITLOG, '-|', 'git-log', "$base..$parent")
+                        or die "Cannot call git-log: $!";
+                        my $mergedhash;
+                        while (<GITLOG>) {
+                            chomp;
+                            if (!defined $mergedhash) {
+                                if (m/^commit\s+(.+)$/) {
+                                    $mergedhash = $1;
+                                } else {
+                                    next;
+                                }
+                            } else {
+                                # grab the first line that looks non-rfc822
+                                # aka has content after leading space
+                                if (m/^\s+(\S.*)$/) {
+                                    my $title = $1;
+                                    $title = substr($title,0,100); # truncate
+                                    unshift @merged, "$mergedhash $title";
+                                    undef $mergedhash;
+                                }
+                            }
+                        }
+                        close GITLOG;
+                        if (@merged) {
+                            $commit->{mergemsg} = $commit->{message};
+                            $commit->{mergemsg} .= "\nSummary of merged commits:\n\n";
+                            foreach my $summary (@merged) {
+                                $commit->{mergemsg} .= "\t$summary\n";
+                            }
+                            $commit->{mergemsg} .= "\n\n";
+                            # print "Message for $commit->{hash} \n$commit->{mergemsg}";
+                        }
+                    }
+                }
+            }
+        }
+
+        # convert the date to CVS-happy format
+        $commit->{date} = "$2 $1 $4 $3 $5" if ( $commit->{date} =~ /^\w+\s+(\w+)\s+(\d+)\s+(\d+:\d+:\d+)\s+(\d+)\s+([+-]\d+)$/ );
+
+        if ( defined ( $lastpicked ) )
+        {
+            my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
+            while ( <FILELIST> )
+            {
+                unless ( /^:\d{6}\s+\d{3}(\d)\d{2}\s+[a-zA-Z0-9]{40}\s+([a-zA-Z0-9]{40})\s+(\w)\s+(.*)$/o )
+                {
+                    die("Couldn't process git-diff-tree line : $_");
+                }
+
+                # $log->debug("File mode=$1, hash=$2, change=$3, name=$4");
+
+                my $git_perms = "";
+                $git_perms .= "r" if ( $1 & 4 );
+                $git_perms .= "w" if ( $1 & 2 );
+                $git_perms .= "x" if ( $1 & 1 );
+                $git_perms = "rw" if ( $git_perms eq "" );
+
+                if ( $3 eq "D" )
+                {
+                    #$log->debug("DELETE   $4");
+                    $head->{$4} = {
+                        name => $4,
+                        revision => $head->{$4}{revision} + 1,
+                        filehash => "deleted",
+                        commithash => $commit->{hash},
+                        modified => $commit->{date},
+                        author => $commit->{author},
+                        mode => $git_perms,
+                    };
+                    $db_insert_rev->execute($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                }
+                elsif ( $3 eq "M" )
+                {
+                    #$log->debug("MODIFIED $4");
+                    $head->{$4} = {
+                        name => $4,
+                        revision => $head->{$4}{revision} + 1,
+                        filehash => $2,
+                        commithash => $commit->{hash},
+                        modified => $commit->{date},
+                        author => $commit->{author},
+                        mode => $git_perms,
+                    };
+                    $db_insert_rev->execute($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                }
+                elsif ( $3 eq "A" )
+                {
+                    #$log->debug("ADDED    $4");
+                    $head->{$4} = {
+                        name => $4,
+                        revision => 1,
+                        filehash => $2,
+                        commithash => $commit->{hash},
+                        modified => $commit->{date},
+                        author => $commit->{author},
+                        mode => $git_perms,
+                    };
+                    $db_insert_rev->execute($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                }
+                else
+                {
+                    $log->warn("UNKNOWN FILE CHANGE mode=$1, hash=$2, change=$3, name=$4");
+                    die;
+                }
+            }
+            close FILELIST;
+        } else {
+            # this is used to detect files removed from the repo
+            my $seen_files = {};
+
+            my $filepipe = open(FILELIST, '-|', 'git-ls-tree', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
+            while ( <FILELIST> )
+            {
+                unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\s+(.*)$/o )
+                {
+                    die("Couldn't process git-ls-tree line : $_");
+                }
+
+                my ( $git_perms, $git_type, $git_hash, $git_filename ) = ( $1, $2, $3, $4 );
+
+                $seen_files->{$git_filename} = 1;
+
+                my ( $oldhash, $oldrevision, $oldmode ) = (
+                    $head->{$git_filename}{filehash},
+                    $head->{$git_filename}{revision},
+                    $head->{$git_filename}{mode}
+                );
+
+                if ( $git_perms =~ /^\d\d\d(\d)\d\d/o )
+                {
+                    $git_perms = "";
+                    $git_perms .= "r" if ( $1 & 4 );
+                    $git_perms .= "w" if ( $1 & 2 );
+                    $git_perms .= "x" if ( $1 & 1 );
+                } else {
+                    $git_perms = "rw";
+                }
+
+                # unless the file exists with the same hash, we need to update it ...
+                unless ( defined($oldhash) and $oldhash eq $git_hash and defined($oldmode) and $oldmode eq $git_perms )
+                {
+                    my $newrevision = ( $oldrevision or 0 ) + 1;
+
+                    $head->{$git_filename} = {
+                        name => $git_filename,
+                        revision => $newrevision,
+                        filehash => $git_hash,
+                        commithash => $commit->{hash},
+                        modified => $commit->{date},
+                        author => $commit->{author},
+                        mode => $git_perms,
+                    };
+
+
+                    $db_insert_rev->execute($git_filename, $newrevision, $git_hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                }
+            }
+            close FILELIST;
+
+            # Detect deleted files
+            foreach my $file ( keys %$head )
+            {
+                unless ( exists $seen_files->{$file} or $head->{$file}{filehash} eq "deleted" )
+                {
+                    $head->{$file}{revision}++;
+                    $head->{$file}{filehash} = "deleted";
+                    $head->{$file}{commithash} = $commit->{hash};
+                    $head->{$file}{modified} = $commit->{date};
+                    $head->{$file}{author} = $commit->{author};
+
+                    $db_insert_rev->execute($file, $head->{$file}{revision}, $head->{$file}{filehash}, $commit->{hash}, $commit->{date}, $commit->{author}, $head->{$file}{mode});
+                }
+            }
+            # END : "Detect deleted files"
+        }
+
+
+        if (exists $commit->{mergemsg})
+        {
+            $db_insert_mergelog->execute($commit->{hash}, $commit->{mergemsg});
+        }
+
+        $lastpicked = $commit->{hash};
+
+        $self->_set_prop("last_commit", $commit->{hash});
+    }
+
+    $db_delete_head->execute();
+    foreach my $file ( keys %$head )
+    {
+        $db_insert_head->execute(
+            $file,
+            $head->{$file}{revision},
+            $head->{$file}{filehash},
+            $head->{$file}{commithash},
+            $head->{$file}{modified},
+            $head->{$file}{author},
+            $head->{$file}{mode},
+        );
+    }
+    # invalidate the gethead cache
+    $self->{gethead_cache} = undef;
+
+
+    # Ending exclusive lock here
+    $self->{dbh}->commit() or die "Failed to commit changes to SQLite";
+}
+
+sub _headrev
+{
+    my $self = shift;
+    my $filename = shift;
+
+    my $db_query = $self->{dbh}->prepare_cached("SELECT filehash, revision, mode FROM head WHERE name=?",{},1);
+    $db_query->execute($filename);
+    my ( $hash, $revision, $mode ) = $db_query->fetchrow_array;
+
+    return ( $hash, $revision, $mode );
+}
+
+sub _get_prop
+{
+    my $self = shift;
+    my $key = shift;
+
+    my $db_query = $self->{dbh}->prepare_cached("SELECT value FROM properties WHERE key=?",{},1);
+    $db_query->execute($key);
+    my ( $value ) = $db_query->fetchrow_array;
+
+    return $value;
+}
+
+sub _set_prop
+{
+    my $self = shift;
+    my $key = shift;
+    my $value = shift;
+
+    my $db_query = $self->{dbh}->prepare_cached("UPDATE properties SET value=? WHERE key=?",{},1);
+    $db_query->execute($value, $key);
+
+    unless ( $db_query->rows )
+    {
+        $db_query = $self->{dbh}->prepare_cached("INSERT INTO properties (key, value) VALUES (?,?)",{},1);
+        $db_query->execute($key, $value);
+    }
+
+    return $value;
+}
+
+=head2 gethead
+
+=cut
+
+sub gethead
+{
+    my $self = shift;
+
+    return $self->{gethead_cache} if ( defined ( $self->{gethead_cache} ) );
+
+    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, mode, revision, modified, commithash, author FROM head",{},1);
+    $db_query->execute();
+
+    my $tree = [];
+    while ( my $file = $db_query->fetchrow_hashref )
+    {
+        push @$tree, $file;
+    }
+
+    $self->{gethead_cache} = $tree;
+
+    return $tree;
+}
+
+=head2 getlog
+
+=cut
+
+sub getlog
+{
+    my $self = shift;
+    my $filename = shift;
+
+    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, author, mode, revision, modified, commithash FROM revision WHERE name=? ORDER BY revision DESC",{},1);
+    $db_query->execute($filename);
+
+    my $tree = [];
+    while ( my $file = $db_query->fetchrow_hashref )
+    {
+        push @$tree, $file;
+    }
+
+    return $tree;
+}
+
+=head2 getmeta
+
+This function takes a filename (with path) argument and returns a hashref of
+metadata for that file.
+
+=cut
+
+sub getmeta
+{
+    my $self = shift;
+    my $filename = shift;
+    my $revision = shift;
+
+    my $db_query;
+    if ( defined($revision) and $revision =~ /^\d+$/ )
+    {
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM revision WHERE name=? AND revision=?",{},1);
+        $db_query->execute($filename, $revision);
+    }
+    elsif ( defined($revision) and $revision =~ /^[a-zA-Z0-9]{40}$/ )
+    {
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM revision WHERE name=? AND commithash=?",{},1);
+        $db_query->execute($filename, $revision);
+    } else {
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM head WHERE name=?",{},1);
+        $db_query->execute($filename);
+    }
+
+    return $db_query->fetchrow_hashref;
+}
+
+=head2 commitmessage
+
+this function takes a commithash and returns the commit message for that commit
+
+=cut
+sub commitmessage
+{
+    my $self = shift;
+    my $commithash = shift;
+
+    die("Need commithash") unless ( defined($commithash) and $commithash =~ /^[a-zA-Z0-9]{40}$/ );
+
+    my $db_query;
+    $db_query = $self->{dbh}->prepare_cached("SELECT value FROM commitmsgs WHERE key=?",{},1);
+    $db_query->execute($commithash);
+
+    my ( $message ) = $db_query->fetchrow_array;
+
+    if ( defined ( $message ) )
+    {
+        $message .= " " if ( $message =~ /\n$/ );
+        return $message;
+    }
+
+    my @lines = safe_pipe_capture("git-cat-file", "commit", $commithash);
+    shift @lines while ( $lines[0] =~ /\S/ );
+    $message = join("",@lines);
+    $message .= " " if ( $message =~ /\n$/ );
+    return $message;
+}
+
+=head2 gethistory
+
+This function takes a filename (with path) argument and returns an arrayofarrays 
+containing revision,filehash,commithash ordered by revision descending
+
+=cut
+sub gethistory
+{
+    my $self = shift;
+    my $filename = shift;
+
+    my $db_query;
+    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM revision WHERE name=? ORDER BY revision DESC",{},1);
+    $db_query->execute($filename);
+
+    return $db_query->fetchall_arrayref;
+}
+
+=head2 gethistorydense
+
+This function takes a filename (with path) argument and returns an arrayofarrays 
+containing revision,filehash,commithash ordered by revision descending.
+
+This version of gethistory skips deleted entries -- so it is useful for annotate.
+The 'dense' part is a reference to a '--dense' option available for git-rev-list 
+and other git tools that depend on it.
+
+=cut
+sub gethistorydense
+{
+    my $self = shift;
+    my $filename = shift;
+
+    my $db_query;
+    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM revision WHERE name=? AND filehash!='deleted' ORDER BY revision DESC",{},1);
+    $db_query->execute($filename);
+
+    return $db_query->fetchall_arrayref;
+}
+
+=head2 in_array()
+
+from Array::PAT - mimics the in_array() function
+found in PHP. Yuck but works for small arrays.
+
+=cut
+sub in_array
+{
+    my ($check, @array) = @_;
+    my $retval = 0;
+    foreach my $test (@array){
+        if($check eq $test){
+            $retval =  1;
+        }
+    }
+    return $retval;
+}
+
+=head2 safe_pipe_capture
+
+an alterative to `command` that allows input to be passed as an array
+to work around shell problems with weird characters in arguments
+
+=cut
+sub safe_pipe_capture {
+
+    my @output;
+
+    if (my $pid = open my $child, '-|') {
+        @output = (<$child>);
+        close $child or die join(' ',@_).": $! $?";
+    } else {
+        exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
+    }
+    return wantarray ? @output : join('',@output);
+}
+
+
+1;
-- 
1.2.2.gd9a1-dirty
