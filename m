From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Geolocation support
Date: Sun, 8 Feb 2015 17:24:29 -0800
Message-ID: <CAPc5daW5jYAj5z6UMJAQLoWS4L6OH-NSvbGBMd3LO0qCV40a4A@mail.gmail.com>
References: <87mwrncfkh.fsf@ethzero.com> <CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
 <CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
 <7vhahtfuzm.fsf@alter.siamese.dyndns.org> <87h9uwvtm2.fsf@ethzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>
To: Alessandro Di Marco <dmr@ethzero.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:25:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKd5s-0004jL-Me
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 02:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759086AbbBIBYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 20:24:51 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:43755 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbbBIBYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 20:24:50 -0500
Received: by mail-oi0-f48.google.com with SMTP id a3so1845003oib.7
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 17:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1nM3JaAQ9nCLGl3AhyJMSJu3FGRNzF3J113EnDASRzU=;
        b=GZrJ21pPUbMhzgc4z8LeoqBVqC7Wh6VVVGEWEz2dd24yD406TaEf6M3Ph5bIWojg6A
         eym/PJ8LcrV3ie1Y0ol5iWDJWPeh6SLqnjaazjerebOEjQfmtmsDH3sWclUX5Q8oCEzD
         LAb1TrT6fYnRoyp1iPpLOVCcr7Fm2B/ntlECN0tbz5ThYsr7j84cPoCm5eTBekRS8kUW
         69JEdDpaB1fJwxu8WkczzfzM7dK+ih2dcP5deCU3000Sz8R8lqJnVs+nSTuefJizg6uO
         kSMk0Dgt/xiGHXw1ssz7rsivq48cpxpDT3oLAO+/HfopWJ9MN0anfNjG9+mqp9Mo88a+
         SoSw==
X-Received: by 10.182.60.197 with SMTP id j5mr9996210obr.85.1423445089853;
 Sun, 08 Feb 2015 17:24:49 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Sun, 8 Feb 2015 17:24:29 -0800 (PST)
In-Reply-To: <87h9uwvtm2.fsf@ethzero.com>
X-Google-Sender-Auth: PSsWTomAgYjRYCVz6MiyviEX0J8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263541>

In case I was not clear, I do not think it is likely for us to accept
a patch that mucks with object header fields with this information.
Have them in the log text and let UI interpret them.

On Sun, Feb 8, 2015 at 4:03 PM, Alessandro Di Marco <dmr@ethzero.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I would personally find the "feature" cute, but
>
> <snip>
>
>> Wouldn't it be sufficient to treat this in a similar way as
>> references to tracker entries and references to other commit objects
>> in the text of the commit message body are treated by gitk and
>> friends?  Just embed the information in the log text somewhere and
>> teach the UI how they look like and what to do with them.
>
> Sorry for the delay, I've been a little busy lately :-)
>
> I revised the old patch and moved the location info into a pair of extra
> headers, resp. author-location and committer-location. This way location
> unaware clients do not try to interpret the extra stuff and things stay
> smooth as usual. I tried to push/clone a location aware repository
> to/from github and it seemed to work as expected (ie. location was
> retained by github servers).
>
> The patch is still rough; only gitk interpret the location info at the
> moment (see http://tinypic.com/r/wars40/5), but log pretty printing is
> on the way out.
>
> The expected location format is "CITY, COUNTRY (LAT, LON)". Location is
> provided by two envvars, resp. GIT_AUTHOR_LOCATION and
> GIT_COMMITTER_LOCATION, that should be updated prior committing. E.g.
>
> $ export GIT_AUTHOR_LOCATION="Paris, France (48.8667, 2.3333)"
> $ export GIT_COMMITTER_LOCATION="Paris, France (48.8667, 2.3333)"
> $ git commit -a -s -m "foo"
>
> The patch honors the committer location on amending, etc. and gitk
> reports it with a red circle on the map. Author's location is indicated
> by a red point instead. Keep in mind that the soundness of the envvars
> content is taken for grant on commit (ie. no sanity checks yet), so
> stick carefully to the above format or gitk will whine.
>
> Signed-off-by: Alessandro Di Marco <dmr@ethzero.com>
> ---
>  builtin/commit.c |  48 ++++-
>  commit.c         |  10 +-
>  commit.h         |   1 +
>  gitk-git/gitk    | 552 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 590 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7d90c35..188f424 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -629,6 +629,38 @@ static int author_date_is_interesting(void)
>         return author_message || force_date;
>  }
>
> +static int location_is_safe(char *loc)
> +{
> +       if (loc) {
> +               /* FIXME: sanity checks here */
> +       }
> +
> +       return !!loc;
> +}
> +
> +static int determine_location(struct strbuf *location)
> +{
> +       char *loc;
> +
> +       if (!amend) {
> +               loc = getenv("GIT_AUTHOR_LOCATION");
> +               if (location_is_safe(loc)) {
> +                       strbuf_addstr(location, "author-location ");
> +                       strbuf_addstr(location, loc);
> +                       strbuf_addch(location, '\n');
> +               }
> +       }
> +
> +       loc = getenv("GIT_COMMITTER_LOCATION");
> +       if (location_is_safe(loc)) {
> +               strbuf_addstr(location, "committer-location ");
> +               strbuf_addstr(location, loc);
> +               strbuf_addch(location, '\n');
> +       }
> +
> +       return 1;
> +}
> +
>  static void adjust_comment_line_char(const struct strbuf *sb)
>  {
>         char candidates[] = "#;@!$%^&|:";
> @@ -1630,6 +1662,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>
>         struct strbuf sb = STRBUF_INIT;
>         struct strbuf author_ident = STRBUF_INIT;
> +       struct strbuf location = STRBUF_INIT;
>         const char *index_file, *reflog_msg;
>         char *nl;
>         unsigned char sha1[20];
> @@ -1669,6 +1702,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>                 return 1;
>         }
>
> +       if (!determine_location(&location)) {
> +               rollback_index_files();
> +               return 1;
> +       }
> +
>         /* Determine parents */
>         reflog_msg = getenv("GIT_REFLOG_ACTION");
>         if (!current_head) {
> @@ -1745,13 +1783,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         }
>
>         if (amend) {
> -               const char *exclude_gpgsig[2] = { "gpgsig", NULL };
> -               extra = read_commit_extra_headers(current_head, exclude_gpgsig);
> +               const char *exclude[3] = { "gpgsig", "committer-location", NULL };
> +               extra = read_commit_extra_headers(current_head, exclude);
>         } else {
>                 struct commit_extra_header **tail = &extra;
>                 append_merge_tag_headers(parents, &tail);
>         }
>
> +       if (location.len > 0) {
> +               extra = read_commit_extra_header_lines(location.buf,
> +                                           location.len, NULL, extra);
> +       }
> +       strbuf_release(&location);
> +
>         if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
>                          parents, sha1, author_ident.buf, sign_commit, extra)) {
>                 rollback_index_files();
> diff --git a/commit.c b/commit.c
> index a8c7577..0b4e66e 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -12,8 +12,6 @@
>  #include "prio-queue.h"
>  #include "sha1-lookup.h"
>
> -static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
> -
>  int save_commit_buffer = 1;
>
>  const char *commit_type = "commit";
> @@ -1284,7 +1282,7 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
>         struct commit_extra_header *extra = NULL;
>         unsigned long size;
>         const char *buffer = get_commit_buffer(commit, &size);
> -       extra = read_commit_extra_header_lines(buffer, size, exclude);
> +       extra = read_commit_extra_header_lines(buffer, size, exclude, extra);
>         unuse_commit_buffer(commit, buffer);
>         return extra;
>  }
> @@ -1326,11 +1324,11 @@ static int excluded_header_field(const char *field, size_t len, const char **exc
>         return 0;
>  }
>
> -static struct commit_extra_header *read_commit_extra_header_lines(
> +struct commit_extra_header *read_commit_extra_header_lines(
>         const char *buffer, size_t size,
> -       const char **exclude)
> +       const char **exclude, struct commit_extra_header *extra)
>  {
> -       struct commit_extra_header *extra = NULL, **tail = &extra, *it = NULL;
> +       struct commit_extra_header **tail = extra ? &extra->next : &extra, *it = NULL;
>         const char *line, *next, *eof, *eob;
>         struct strbuf buf = STRBUF_INIT;
>
> diff --git a/commit.h b/commit.h
> index 5cc1e7e..d6345a6 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -326,6 +326,7 @@ extern int commit_tree_extended(const char *msg, size_t msg_len,
>                                 struct commit_extra_header *);
>
>  extern struct commit_extra_header *read_commit_extra_headers(struct commit *, const char **);
> +extern struct commit_extra_header *read_commit_extra_header_lines(const char *, size_t, const char **, struct commit_extra_header *);
>
>  extern void free_commit_extra_headers(struct commit_extra_header *extra);
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 78358a7..550688d 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -8,6 +8,7 @@ exec wish "$0" -- "$@"
>  # either version 2, or (at your option) any later version.
>
>  package require Tk
> +package require Img
>
>  proc hasworktree {} {
>      return [expr {[exec git rev-parse --is-bare-repository] == "false" &&
> @@ -700,7 +701,7 @@ proc newvarc {view id} {
>         if {![info exists commitinfo($id)]} {
>             parsecommit $id $commitdata($id) 1
>         }
> -       set cdate [lindex [lindex $commitinfo($id) 4] 0]
> +       set cdate [lindex [lindex $commitinfo($id) 5] 0]
>         if {![string is integer -strict $cdate]} {
>             set cdate 0
>         }
> @@ -1672,8 +1673,10 @@ proc parsecommit {id contents listed} {
>      set headline {}
>      set auname {}
>      set audate {}
> +    set auloc {}
>      set comname {}
>      set comdate {}
> +    set coloc {}
>      set hdrend [string first "\n\n" $contents]
>      if {$hdrend < 0} {
>         # should never happen...
> @@ -1690,6 +1693,10 @@ proc parsecommit {id contents listed} {
>         } elseif {$tag == "committer"} {
>             set comdate [lrange $line end-1 end]
>             set comname [join [lrange $line 1 end-2] " "]
> +       } elseif {$tag == "author-location"} {
> +           set auloc [lrange $line 1 end]
> +       } elseif {$tag == "committer-location"} {
> +           set coloc [lrange $line 1 end]
>         }
>      }
>      set headline {}
> @@ -1725,8 +1732,8 @@ proc parsecommit {id contents listed} {
>         set diff [string range $comment $i+1 end]
>         set comment [string range $comment 0 $i-1]
>      }
> -    set commitinfo($id) [list $headline $auname $audate \
> -                            $comname $comdate $comment $hasnote $diff]
> +    set commitinfo($id) [list $headline $auname $audate $auloc \
> +                            $comname $comdate $coloc $comment $hasnote $diff]
>  }
>
>  proc getcommit {id} {
> @@ -2041,7 +2048,8 @@ proc makedroplist {w varname args} {
>  }
>
>  proc makewindow {} {
> -    global canv canv2 canv3 linespc charspc ctext cflist cscroll
> +    global canv canv2 canv3 canv4 linespc charspc ctext cflist cscroll
> +    global wwidth wheight
>      global tabstop
>      global findtype findtypemenu findloc findstring fstring geometry
>      global entries sha1entry sha1string sha1but
> @@ -2128,6 +2136,7 @@ proc makewindow {} {
>          set geometry(botwidth) [expr {50 * $charspc}]
>          set geometry(pwsash0) [list [expr {40 * $charspc}] 2]
>          set geometry(pwsash1) [list [expr {60 * $charspc}] 2]
> +        set geometry(pwsash2) [list [expr {80 * $charspc}] 2]
>      }
>
>      # the upper half will have a paned window, a scroll bar to the right, and some stuff below
> @@ -2138,6 +2147,489 @@ proc makewindow {} {
>         .tf.histframe.pwclist configure -sashpad 0 -handlesize 4
>      }
>
> +    set world {
> +       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
> +       iVoUKFJJf//Z
> +    }
> +
>      # create three canvases
>      set cscroll .tf.histframe.csb
>      set canv .tf.histframe.pwclist.canv
> @@ -2156,15 +2648,24 @@ proc makewindow {} {
>         -selectbackground $selectbgcolor \
>         -background $bgcolor -bd 0 -yscrollincr $linespc
>      .tf.histframe.pwclist add $canv3
> +    set canv4 .tf.histframe.pwclist.canv4
> +    canvas $canv4
> +    .tf.histframe.pwclist add $canv4
> +    image create photo world -data $world
> +    $canv4 create image 0 0 -anchor nw -image world
> +    set wheight [image height world]
> +    set wwidth [image width world]
>      if {$use_ttk} {
>         bind .tf.histframe.pwclist <Map> {
>             bind %W <Map> {}
> +           .tf.histframe.pwclist sashpos 2 [lindex $::geometry(pwsash2) 0]
>             .tf.histframe.pwclist sashpos 1 [lindex $::geometry(pwsash1) 0]
>             .tf.histframe.pwclist sashpos 0 [lindex $::geometry(pwsash0) 0]
>         }
>      } else {
>         eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
>         eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
> +       eval .tf.histframe.pwclist sash place 2 $geometry(pwsash2)
>      }
>
>      # a scroll bar to rule them
> @@ -2805,9 +3306,11 @@ proc savestuff {w} {
>         if {$use_ttk} {
>             puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sashpos 0] 1\""
>             puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
> +           puts $f "set geometry(pwsash2) \"[.tf.histframe.pwclist sashpos 2] 1\""
>         } else {
>             puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash coord 0]\""
>             puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sash coord 1]\""
> +           puts $f "set geometry(pwsash2) \"[.tf.histframe.pwclist sash coord 2]\""
>         }
>         puts $f "set geometry(botwidth) [winfo width .bleft]"
>         puts $f "set geometry(botheight) [winfo height .bleft]"
> @@ -5211,7 +5714,7 @@ proc readdiffindex {fd serial inst} {
>      if {$isdiff && ![commitinview $nullid2 $curview]} {
>         # add the line for the changes in the index to the graph
>         set hl [mc "Local changes checked in to index but not committed"]
> -       set commitinfo($nullid2) [list  $hl {} {} {} {} "    $hl\n"]
> +       set commitinfo($nullid2) [list  $hl {} {} {} {} {} {} "    $hl\n"]
>         set commitdata($nullid2) "\n    $hl\n"
>         if {[commitinview $nullid $curview]} {
>             removefakerow $nullid
> @@ -5247,7 +5750,7 @@ proc readdifffiles {fd serial inst} {
>      if {$isdiff && ![commitinview $nullid $curview]} {
>         # add the line for the local diff to the graph
>         set hl [mc "Local uncommitted changes, not checked in to index"]
> -       set commitinfo($nullid) [list  $hl {} {} {} {} "    $hl\n"]
> +       set commitinfo($nullid) [list  $hl {} {} {} {} {} {} "    $hl\n"]
>         set commitdata($nullid) "\n    $hl\n"
>         if {[commitinview $nullid2 $curview]} {
>             set p $nullid2
> @@ -6036,7 +6539,7 @@ proc drawcmittext {id row col} {
>         || [info exists idotherrefs($id)]} {
>         set xt [drawtags $id $x $xt $y]
>      }
> -    if {[lindex $commitinfo($id) 6] > 0} {
> +    if {[lindex $commitinfo($id) 8] > 0} {
>         set xt [drawnotesign $xt $y]
>      }
>      set headline [lindex $commitinfo($id) 0]
> @@ -7123,7 +7626,8 @@ proc make_idmark {id} {
>  }
>
>  proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
> -    global canv ctext commitinfo selectedline
> +    global canv canv4 ctext commitinfo selectedline
> +    global wwidth wheight
>      global canvy0 linespc parents children curview
>      global currentid sha1entry
>      global commentend idtags linknum
> @@ -7209,9 +7713,31 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
>      }
>      set info $commitinfo($id)
>      set date [formatdate [lindex $info 2]]
> -    $ctext insert end "[mc "Author"]: [lindex $info 1]  $date\n"
> -    set date [formatdate [lindex $info 4]]
> -    $ctext insert end "[mc "Committer"]: [lindex $info 3]  $date\n"
> +    set place ""
> +    regexp {^([^\(]+)} [lindex $info 3] -> place
> +    $ctext insert end "[mc "Author"]: [lindex $info 1]  $date  [string trim $place]\n"
> +    $canv4 delete "auspot"
> +    set lat ""
> +    set lon ""
> +    regexp {\((-?[0-9\.]+), (-?[0-9\.]+)\)$} [lindex $info 3] -> lat lon
> +    if {$lat != "" && $lon != ""} {
> +       set wx [expr {round(($lon + 180) * $wwidth / 360)} ]
> +       set wy [expr {round((90 - $lat) * $wheight / 180)} ]
> +       $canv4 create oval [expr {$wx - 2}] [expr {$wy - 2}] [expr {$wx + 2}] [expr {$wy + 2}] -tags "auspot" -fill #F00
> +    }
> +    set date [formatdate [lindex $info 5]]
> +    set place ""
> +    regexp {^([^\(]+)} [lindex $info 6] -> place
> +    $ctext insert end "[mc "Committer"]: [lindex $info 4]  $date  [string trim $place]\n"
> +    $canv4 delete "cospot"
> +    set lat ""
> +    set lon ""
> +    regexp {\((-?[0-9\.]+), (-?[0-9\.]+)\)$} [lindex $info 6] -> lat lon
> +    if {$lat != "" && $lon != ""} {
> +       set wx [expr {round(($lon + 180) * $wwidth / 360)} ]
> +       set wy [expr {round((90 - $lat) * $wheight / 180)} ]
> +       $canv4 create oval [expr {$wx - 2}] [expr {$wy - 2}] [expr {$wx + 2}] [expr {$wy + 2}] -tags "cospot" -outline #F00
> +    }
>      if {[info exists idtags($id)]} {
>         $ctext insert end [mc "Tags:"]
>         foreach tag $idtags($id) {
> @@ -7263,7 +7789,7 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
>         dispneartags 1
>      }
>      $ctext insert end "\n"
> -    set comment [lindex $info 5]
> +    set comment [lindex $info 7]
>      if {[string first "\r" $comment] >= 0} {
>         set comment [string map {"\r" "\n    "} $comment]
>      }
> @@ -7628,7 +8154,7 @@ proc showinlinediff {ids} {
>      global treediffs
>
>      set info $commitinfo($ids)
> -    set diff [lindex $info 7]
> +    set diff [lindex $info 9]
>      set difflines [split $diff "\n"]
>
>      initblobdiffvars
> --
> 2.3.0.341.g8c131eb.dirty
>
