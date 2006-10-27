X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Peter Baumann" <peter.baumann@gmail.com>
Subject: [BUG] git-cvsexportcommit doesn't handle added directories
Date: Fri, 27 Oct 2006 11:38:59 +0200
Message-ID: <802d21790610270238l31042731t80313c8f467a1a55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 09:39:54 +0000 (UTC)
Cc: "Martin Langhoff" <martin@catalyst.net.nz>,
	"Yann Dirson" <ydirson@altern.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hR6o0XD+xBtoCfmy3i/SEjtbzZkW8QYxTJ5sJL/BzRJio+troDEYjI5H3vOLFnGklD5Um/JSBrsO8qNV85sLtEidnrYAvp2gY77cylC2Yr53IZnZ+GNTbMnkKgqZnVEb+P1P0AtKH6dbIwyDCALfMLehCMVvA6ypyh7xMQOJwSA=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30316>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdOBa-00014i-Jd for gcvg-git@gmane.org; Fri, 27 Oct
 2006 11:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422753AbWJ0JjD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 05:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946269AbWJ0JjC
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 05:39:02 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:4414 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946270AbWJ0JjA
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 05:39:00 -0400
Received: by ug-out-1314.google.com with SMTP id 22so554483uga for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 02:38:59 -0700 (PDT)
Received: by 10.78.157.8 with SMTP id f8mr4170104hue; Fri, 27 Oct 2006
 02:38:59 -0700 (PDT)
Received: by 10.78.162.18 with HTTP; Fri, 27 Oct 2006 02:38:59 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

There is a problem in git-cvsexportcommit if I add a directory with some new
files in git. It dies in safe_pipe_capture().

Analysis:

foreach my $f (@afiles) {
    # This should return only one value
    my @status = grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'status' ,$f));
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    #    OK. Here it tries to run "cvs -q status src/newdirectory/newfile"
    [...]
}

[...]

# An alternative to `command` that allows input to be passed as an array
# to work around shell problems with weird characters in arguments
# if the exec returns non-zero we die
sub safe_pipe_capture {
    my @output;
    if (my $pid = open my $child, '-|') {
        @output = (<$child>);
        print "before close\n";
        close $child or die join(' ',@_).": x$!x y$?y";
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         #   I changed it to see which error will be printed
        print "after close\n";
    } else {
        exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
    }
    return wantarray ? @output : join('',@output);
}


Output:
[...]
siprbaum@faui40a.informatik.uni-erlangen.de's password:
cvs [status aborted]: no such directory `src/newdir'
before close
cvs -q status src/newdir/newfile.java: xx y256y at
/home/peter/src/git-cvsexportcommit.perl line 317.
                                      ^^^^^
Don't be confused about the wrong line number. I have some other stuff
(formating
the commit message in a special way) in there but I can confirm that the script
dies at the close of the pipe.

Running from a shell the command manually:

  xp:~/project/$ cvs -q status src/newdir/newfile
  siprbaum@faui40a.informatik.uni-erlangen.de's password:
  cvs [status aborted]: no such directory `src/newdir'
  xp:~/project/$ echo $?
  1


Excerpt from the "perldoc -f close"

  [...]
  If the file handle came from a piped open, "close" will additionally
return false if
  one of the other system calls involved fails, or if the program
exits with non-zero
  status.  (If the only problem was that the program exited non-zero, $! will be
  set to 0.)  Closing a pipe also waits for the process executing on the pipe to
  complete, in case you want to look at the output of the pipe afterwards, and
  implicitly puts the exit status value of that command into $?.

  Prematurely closing the read end of a pipe (i.e. before the process
writing to it
  at the other end has closed it) will result in a SIGPIPE being
delivered to the
  writer. If the other end can't handle that, be sure to read all the
data before
  closing the pipe.

So according to the manpage $! should be set to 0, because
"cvs -q status src/newdir/newfile" exits with errorcode 1 as shown above.

Could this have something todo that I have to use ssh to connect to the repo?
(CVSROOT=:extssh:siprbaum@faui40a.informatik.uni-erlangen.de:/path/to/repo)

Any ideas?

Greetings,
