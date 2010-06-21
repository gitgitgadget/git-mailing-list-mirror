From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 00/11 GSoC] gitweb: Split gitweb into modules
Date: Tue, 22 Jun 2010 03:30:36 +0530
Message-ID: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:01:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQp3J-0006QU-0V
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642Ab0FUWBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:01:06 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61837 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318Ab0FUWBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:01:04 -0400
Received: by pwj8 with SMTP id 8so528092pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ghF+w3Q8qLcZHPqP0os7F+ccb+HDdC5BpMipdkEW7W0=;
        b=W3epCIDopt5en4C3ShdbOnzWQJqHHvO2mG6kNtQVNfO5yZyaHVYydoLkr3FDr+cg7V
         HA6888gU5Xqj+V7ygu4kJZo/aa304TgQoXMkmG56wVgWJVT4WQoyI64m0UrBgdl0szYa
         CHiDJYxRHEx0VeoeUs+P1SPTFDcx4AMahpKAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fRCFyUMHqeGiqXPt5cnbqGeM+TcN8+igrRjlusLTUmPK7IHZyb3syLcnTIcFV7HgFt
         12Cphk13X1iAbHLI5QeRkou+hQyBYAczmMJSXlCxAP31X/3HObN0TGaRVDLXr0Rta24o
         tbQpE6lN1JK3Oyd2CWzIQucVW58oLnbIoAc3o=
Received: by 10.142.207.18 with SMTP id e18mr4059787wfg.158.1277157661947;
        Mon, 21 Jun 2010 15:01:01 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.00.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:01:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149443>

The patch series is based on 'pu' branch.

10 patches out of the 11 patches in this patch series split gitweb into
several small sized modules which is one of the goal of my GSoC's project.

The first patch of this patch series is for fixing esc_url function which is
previously missed by commit 425e225.

The second patch is produced by my commit ammend to jakub nareski's
initial commit to prepare splitting of gitweb in the message-id:
http://mid.gmane.org/1276531710-22945-4-git-send-email-jnareb@gmail.com

There is a small ammendment to that patch. 
$(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(mod)'
is changed to
$(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(dir $(mod))';)
because it is better if we gave 'dir $(mod)' as the target for install command
rather than '$(mod)' because it may cause problems in the future when gitweblibdir
is used and the modules are installed elsewhere rather than in /use/share/gitweb.

The modules created and being used by Gitweb are
	Gitweb::Git
	Gitweb::Config
	Gitweb::Request
	Gitweb::Escape
	Gitweb::RepoConfig
	Gitweb::View
	Gitweb::Util
	Gitweb::Format
	Gitweb::Parse

shortlog:
=======

1. gitweb: fix esc_url

The custom CGI escaping done in esc_url failed to escape UTF-8
properly. Fix by using CGI::escape on each sequence of matched
characters instead of sprintf()ing a custom escaping for each byte.

Additionally, the space -> + escape was being escaped due to greedy
matching on the first substitution. Fix by adding space to the
list of characters not handled on the first substitution.

Finally, remove an unnecessary escaping of the + sign.

commit 425e225 has missed fixing esc_url.


2. gitweb: Prepare for splitting gitweb

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.


3. gitweb: Create Gitweb::Git module

Create a Gitweb::Git module in  'gitweb/lib/Gitweb/Git.pm'
to deal with running git commands (and also processing output
of git commands with external programs) from gitweb.

This module is intended as standalone module, which does not require
(include) other gitweb' modules to avoid circular dependencies.  That
is why it includes $GIT variable, even though this variable is
configured during building gitweb.  On the other hand $GIT is more
about git configuration, than gitweb configuration.

Subroutines moved:
	evaluate_git_version
	git_cmd
	quote_command

Update gitweb/Makefile to install Gitweb::Git module alongside gitweb


4. gitweb: Create Gitweb::Config module

Create Gitweb::Config module in 'gitweb/lib/Gitweb/Config.pm'
to store all the configuration variables and subroutines
regarding the gitweb.perl script.

This module depends only on $git_dir from Gitweb::Git and
includes most of the configuration related variables and
subroutines (Including those required for configuration
of gitweb features)

Subroutines moved:
	evaluate_gitweb_config
	configure_gitweb_features
	filter_snapshot_fmts
	gitweb_get_feature
	gitweb_check_feature

Update gitweb/Makefile to install Gitweb::Config module alongside gitweb


5. gitweb: Create Gitweb::Request module

Create a Gitweb::Request module in 'gitweb/lib/Gitweb/Request.pm'
to store and handle all the cgi params and related variables
regarding the gitweb.perl script.

This module is intended as standalone module, which does not require
(include) other gitweb' modules to avoid circular dependencies.

validate_project and validate_action can't be included in this
module due to unmet dependencies

Subroutines moved:
	evaluate_uri
	evaluate_query_params
	validate_pathname
	validate_refname

Update gitweb/Makefile to install Gitweb::Request module alongside gitweb


6. gitweb: Create Gitweb::Escape module

Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
to store all the quoting/unquoting and escaping subroutines
regarding the gitweb.perl script.

This module imports $fallback_encoding variable from
Gitweb::Config module to use it in sub 'to_utf8'

Subroutines moved:
	to_utf8
	esc_param
	esc_url
	esc_html
	esc_path
	quot_cec
	quot_upr
	unquote
	untabify

Update gitweb/Makefile to install Gitweb::Escape module alongside gitweb


7. gitweb: Create Gitweb::RepoConfig module

Create a Gitweb::RepoConfig module in 'gitweb/lib/Gitweb/RepoConfig.pm'
to store and handle all the configuration and subroutines
related to a single repository regarding the gitweb.perl script.

This module depend on several other modules like Git.pm,
Config.pm, Request.pm and Escape.pm.

It also include subroutines regarding project_list and
it's handling.

Subroutines moved:
	check_head_link
	check_export_ok
	hash_set_multi
	git_parse_project_config
	config_to_bool
	config_to_int
	config_to_multi
	git_get_project_config
	git_get_project_description
	git_get_project_ctags
	git_populate_project_tagcloud
	git_show_project_tagcloud
	git_get_project_url_list
	git_get_projects_list
	git_get_project_list_from_file
	git_get_project_owner
	get_file_owner
	project_in_list

Update gitweb/Makefile to install Gitweb::RepoConfig module
alongside gitweb


8. gitweb: Create Gitweb::View module

Create Gitweb::View module in 'gitweb/lib/Gitweb/View.pm'
to store the subroutines related to the HTML output
for gitweb.

This module depends on Git.pm, Config.pm, Request.pm,
Escape.pm and RepoConfig.pm. Some subroutines which
output HTML but are not included in this module due
to unmet dependencies

Subroutines moved:
	href
	chop_str
	chop_and_escape_str
	age_class
	age_string
	S_ISGITLINK
	mode_str
	file_type
	file_type_long
	get_page_title
	git_header_html
	git_footer_html
	die_error
	git_print_page_nav
	format_paging_nav
	get_feed_info
	insert_file
	git_print_header_div
	print_local_time
	format_local_time
	git_print_page_path
	git_get_link_target
	normalize_link_target
	git_print_tree_entry
	print_sort_th
	format_sort_th

Update 'gitweb/Makefile' to install Gitweb::View alongside gitweb.


9. gitweb: Create Gitweb::Util module

Create Gitweb::Util module in 'gitweb/lib/Gitweb/Util.pm'
to store the git utility subroutines related to gitweb.

This module include subroutines in various categories
such as git utility subs invoking git commands, git
utility subs accessing git repository, mimetype related
subs and HTML output utility subs.

Subroutines moved:
	git_get_head_hash
	git_get_full_hash
	git_get_short_hash
	git_get_hash
	git_get_type
	git_get_hash_by_path
	git_get_path_by_hash
	git_get_last_activity
	git_get_references
	git_get_rev_name_tags
	git_get_heads_list
	git_get_tags_list
	mimetype_guess_file
	mimetype_guess
	blob_mimetype
	blob_contenttype
	guess_file_syntax
	run_highlighter
	fill_from_file_info
	is_deleted
	is_patch_split

Update 'gitweb/Makefile' to install Gitweb::Util alongside gitweb.


10. gitweb: Create Gitweb::Format module

Create Gitweb::Format module in 'gitweb/lib/Gitweb/Format.pm'
to store the subroutines related to formatting of HTML
fragments required for gitweb.

This module depends on Config.pm, View.pm, Escape.pm,
Util.pm and Request.pm. It mainly contain functions returning
short HTML fragments or transforming HTML fragments. Also
include subroutines regarding avatar formatting.

Subroutines moved:
	format_log_line_html
	format_ref_marker
	format_subject_html
	picon_url
	gravatar_url
	git_get_avatar
	format_search_author
	format_author_html
	format_git_diff_header_line
	format_extended_diff_header_line
	format_diff_from_to_header
	format_diff_cc_simplified
	format_diff_line
	format_snapshot_links

Update 'gitweb/Makefile' to install Gitweb::Format alongside gitweb.


11. gitweb: Create Gitweb::Parse module

Create Gitweb::Parse module in 'gitweb/lib/Gitweb/Parse.pm'
to store the subroutines which related to parsing functions
required for gitweb.

This module depends on Git.pm, Escape.pm, View.pm and Util.pm.

Subroutines moved:
	parse_date
	parse_tag
	parse_commit_text
	parse_commit
	parse_commits
	parse_difftree_raw_line
	parsed_difftree_line
	parse_ls_tree_line
	parse_from_to_diffinfo

Update 'gitweb/Makefile' to install Gitweb::Parse alongside gitweb.


Pavan Kumar Sunkara (11):
  gitweb: fix esc_url
  gitweb: Prepare for splitting gitweb
  gitweb: Create Gitweb::Git module
  gitweb: Create Gitweb::Config module
  gitweb: Create Gitweb::Request module
  gitweb: Create Gitweb::Escape module
  gitweb: Create Gitweb::RepoConfig module
  gitweb: Create Gitweb::View module
  gitweb: Create Gitweb::Util module
  gitweb: Create Gitweb::Format module
  gitweb: Create Gitweb::Parse module

 gitweb/Makefile                 |   14 +
 gitweb/gitweb.perl              | 3855 +++------------------------------------
 gitweb/lib/Gitweb/Config.pm     |  498 +++++
 gitweb/lib/Gitweb/Escape.pm     |  175 ++
 gitweb/lib/Gitweb/Format.pm     |  537 ++++++
 gitweb/lib/Gitweb/Git.pm        |   48 +
 gitweb/lib/Gitweb/Parse.pm      |  378 ++++
 gitweb/lib/Gitweb/RepoConfig.pm |  424 +++++
 gitweb/lib/Gitweb/Request.pm    |  153 ++
 gitweb/lib/Gitweb/Util.pm       |  447 +++++
 gitweb/lib/Gitweb/View.pm       | 1022 +++++++++++
 11 files changed, 3909 insertions(+), 3642 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Config.pm
 create mode 100644 gitweb/lib/Gitweb/Escape.pm
 create mode 100644 gitweb/lib/Gitweb/Format.pm
 create mode 100644 gitweb/lib/Gitweb/Git.pm
 create mode 100644 gitweb/lib/Gitweb/Parse.pm
 create mode 100644 gitweb/lib/Gitweb/RepoConfig.pm
 create mode 100644 gitweb/lib/Gitweb/Request.pm
 create mode 100644 gitweb/lib/Gitweb/Util.pm
 create mode 100644 gitweb/lib/Gitweb/View.pm
