From: Adam Simpkins <adam@adamsimpkins.net>
Subject: entry terminator/separator behavior in show_log()
Date: Sun, 27 Apr 2008 21:55:05 -0700
Message-ID: <20080428045504.GA24981@adamsimpkins.net>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 06:56:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqLPE-0003rC-4d
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 06:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbYD1EzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 00:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbYD1EzO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 00:55:14 -0400
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:56040 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYD1EzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 00:55:11 -0400
Received: from relay10.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 58B471B417E;
	Mon, 28 Apr 2008 00:55:09 -0400 (EDT)
Received: by relay10.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id D4DB21B4167;
	Mon, 28 Apr 2008 00:55:08 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 2A97E14100C1; Sun, 27 Apr 2008 21:55:06 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80500>

This is a write-up describing the current entry terminator/separator
behavior of show_log().  I wrote it while updating my "log --graph"
code to work with Junio's new use_terminator flag.

I was initially hoping to find places where we could simplify the
behavior.  However, after examining all of the cases, I'm not sure if
there is much we can do without breaking backwards compatibility too
badly.  Perhaps we should just check this description into
Documentation/technical, for the next person who needs to work with
this part of the code.

Towards the end of the document, I've also listed how the new --graph
option will interact with each of the cases.  I'd love to have
feedback to see if my current plans sound reasonable.



Variables affecting the behavior
--------------------------------

- The sep argument to show_log()

  As far as I can tell, this is always "".  show_log() is sometimes
  invoked with a sep argument of diffopt->msg_sep.  However,
  "git grep -w msg_sep" shows that msg_sep is never set to anything but
  the empty string.

  Perhaps we could just remove this argument, to reduce complexity and
  confusion?

- The line_termination member of struct diff_options

  This is normally '\n', but is set to '\0' if the -z option is
  supplied.

- The use_terminator flag in struct rev_info

  This flag is enabled by --pretty=oneline and --pretty=format.  It is
  off for all other formats.

  This flag has no effect if opt->verbose_header is not set.  If
  opt->verbose_header is set, the behavior is as follows:

  When use_terminator is set, a newline is added to the end of each log
  entry.  diffopt.line_termination is not printed in between entries.
  When use_terminator is not set, diffopt.line_termination is printed
  before all entries except the very first one.

- Whether or not the log entry ends in a terminating newline

  The log entry for CMIT_FMT_ONELINE never ends in a newline.
  The log entry for CMIT_FMT_USERFORMAT only ends in a newline if the
  user explicitly places a newline at the end of the format.

  For all other formats, the entry always ends in a terminating newline.

- Whether or not the log message buffer is empty

  If use_terminator is set and the message buffer returned by
  pretty_print_commit() is empty, no newline is printed between entries.

  This can happen, for example, if CMIT_FMT_USERFORMAT is used with an
  empty format string.  Even though pretty_print_commit() returns an
  empty buffer, the log entry itself does not necessarily have to be
  empty.  For example, the log size will be printed if if the --log-size
  argument is used.

  I'm not sure if there any are other code paths that can also cause
  this to happen.
  

Current Behavior
----------------

(1) For all formats except CMIT_FMT_ONELINE and CMIT_FMT_USERFORMAT:

    diffopt->line_termination is printed before each log entry but the
    first.  This results in diffopt->line_termination in between each
    entry, and not after the final entry.
  
    (1.1)
      When diffopt->line_termination is '\0', this prints a NUL
      character between log entries.

    (1.2)
      When diffopt->line_termination is '\n', this essentially adds an
      extra blank line of padding between log entries, since each log
      entry already ends in a newline.

(2) For CMIT_FMT_ONELINE and CMIT_FMT_USERFORMAT:

    (2.1)
      If use_terminator is set (--pretty=oneline and --pretty=tformat):

      (2.1.1)
        If the message buffer returned by pretty_print_commit() is
        non-empty:

        A newline is printed at the end of each entry.  Since the log
        entry does not end in a newline already, the newline ends the
        last line of the log entry, and there is no extra blank line
        between entries.

        With --pretty=tformat, if the user's format explicitly ends in a
        newline, this will create a blank line at the end of each entry.
        (This looks like a padding line, very similar to case 1 above.
        However, it shows up even after the very last entry.)

      (2.1.2)
        If the message buffer returned by pretty_print_commit() is
        empty:

        A newline is not printed at the end of each entry.  Therefore
        there are no blank lines between log entries.  If the log
        entries are completely empty, nothing at all is printed.

    (2.2)
      If use_terminator is not set (--pretty=format):

      diffopt->line_termination is printed before each log entry but the
      first.  This results in diffopt->line_termination in between each
      entry, and not after the final entry.

      (2.2.1)
        When diffopt->line_termination is '\0', this is reasonable
        behavior, and makes sense for consumption by other scripts.

      (2.2.2)
        When diffopt->line_termination is '\n':

        (2.2.2.1)
          If the user's format is non-empty and does not end in an
          explicit newline, log entries do not end in a newline.
          However, the line_termination character printed before the
          next entry appears to terminate the previous entry, so it
          looks human-readable.  There are no blank lines between
          entries.

          However, no newline is printed after the very last entry.
          This seems like a bug to me, since I would expect that the
          output is normally being read by a human instead of another
          script when diffopt->line_termination is '\n'.

          Fortunately, the log output is normally piped through less,
          and less hides the fact that the output does not end in a
          newline.  It prints a terminating newline for us if the git
          output doesn't end in a newline.

        (2.2.2.2)
          If the user's format does end in an explicit newline, the
          diffopt->line_termination character between entries creates a
          blank line between entries.  The output looks exactly like
          case 1: a blank line show up between entries, but not after
          the very last entry.

        (2.2.2.3)
          If the user's format is the empty string, the log entry will
          either be completely empty, or will already end in a newline.
          The diffopt->line_termination characters printed between
          entries appear as blank padding lines between entries.  If the
          log entries are completely empty the resulting output
          consists solely of padding lines.

(3) opt->verbose_header is unset

    Only a single line of output is printed, terminated with the
    diffopt->line_termination character.

    Note that this differs from case 1!  The line_termination character
    is printed even after the very last entry.


Comments on the current behavior
--------------------------------

The current behavior is fairly complicated.  There are quite a few
corner cases, especially around uncommon behavior (for example,
"--pretty=format:" with an empty format string).  It would be nice to
eliminate some of the complexity.  However, doing so would change the
behavior and potentially break existing user scripts relying on this
behavior.

- Cases 1.1 and 1.2 make perfect sense to me.

- Case 2.1 makes perfect sense to me.

- Case 2.1.2 seems reasonable, but not really necessary.  It might be
  nicer to simply always print a terminating newline even if the message
  buffer is empty.  This would appear as an extra blank line after each
  entry.
  
  The --pretty=tformat option is quite new, so I doubt that many people
  would complain if we changed this behavior.

- Case 2.2.1 makes perfect sense.  There are probably lots of scripts
  out there relying on this behavior.

- I don't really like the behavior for any of the cases under 2.2.2.

  I especially don't like the fact that the output does not end in a
  terminating newline for case 2.2.2.1.

  If the output is for human consumption, the user probably really wants
  case 2.1 (i.e., --pretty=tformat instead of --pretty=format.)
  Hopefully most scripts that parse the log output use the -z option,
  but there are probably also many that don't.  Changing this behavior
  would break these scripts.  Teaching users to use --pretty=tformat
  instead of --pretty=format will probably cause less pain than
  breaking backwards compatibility.


Desired behavior with the new --graph option
--------------------------------------------

- Case 1.1
  (All formats but CMIT_FMT_ONELINE and CMIT_FMT_USERFORMAT,
  line_termination is '\0')

  The graph output should be printed before each line in the log entry.

  Graph output should not be printed between the last newline in the log
  entry and the line_termination character ('\0') for the next log entry.

- Case 1.2
  (All formats but CMIT_FMT_ONELINE and CMIT_FMT_USERFORMAT,
  line_termination is '\n')

  The graph output should be printed before each line in the log entry.

  For each entry but the first, graph padding should also be printed
  *before* the line_termination character.  Otherwise the blank padding
  line between entries will be completely blank, which would leave gaps
  in the graph output.

- Cases 2.1.1 and 2.1.2
  (--pretty=oneline and --pretty=tformat)

  The graph output should be printed before each line in the log entry.

  There is no additional separator between entries, so there is nothing
  else to worry about here.  All log entries always end in a newline,
  which also helps keep things simple.

- Case 2.2.1
  (--pretty=format and line_termination is '\0')

  The graph output should be printed before each line in the log entry.
  Graph output should not be printed between the last newline in the log
  entry and the line_termination character ('\0') for the next log entry.
  
  This behavior is identical to that for case 1.1.

- Case 2.2.2.1
  (--pretty=format, line_termination is '\n', and with a non-empty
  format that doesn't end with a newline)

  The graph output should be printed before each line in the log entry.

  Graph output should not be printed before the line_termination
  character, since this character is merely terminating the last line of
  output from the previous entry.

- Cases 2.2.2.2 and 2.2.2.3
  (--pretty=format, line_termination is '\n', and with a format that
  ends with an explicit newline, or with an empty format)

  The graph output should be printed before each line in the log entry.

  Graph output *should* be before the line_termination character,
  since this character is creating a new blank padding line.

- Case 3
  (opt->verbose_header is unset)

  Each log entry consists of a single line, terminated with the
  line_termination character.  The graph output should be printed before
  each line.

  However, this case currently can't happen via the "git log" command,
  since this command always sets the verbose_header flag.

With the current code, there's not really enough information for
the graphing code in show_log() to distinguish between cases cases
2.2.2.1 and 2.2.2.{2,3}.

In order to do so, I plan to add a new flag to struct rev_info to
indicate whether or not the previous log entry ended in a newline.  The
next invocation of show_log() can check this flag to see if it should
print graph padding before the line_termination character or not.



Thanks for reading, if you made it all the way down here!

-- 
Adam Simpkins
adam@adamsimpkins.net
