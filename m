From: Rutger Nijlunsing <rutger@nospam.com>
Subject: [ANNOUNCE] git-svnconvert: YASI (Yet Another SVN importer)
Date: Sun, 9 Apr 2006 18:34:26 +0200
Organization: M38c
Message-ID: <20060409163426.GA22103@nospam.com>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
X-From: git-owner@vger.kernel.org Sun Apr 09 18:35:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FScsh-0001MC-4j
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 18:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDIQef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 12:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWDIQef
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 12:34:35 -0400
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:61404 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750809AbWDIQee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 12:34:34 -0400
Received: from wingding.demon.nl ([82.161.27.36]:58958)
	by post-25.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FScrp-000LqQ-83
	for git@vger.kernel.org; Sun, 09 Apr 2006 16:34:26 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FScrq-0006Kp-EU
	for git@vger.kernel.org; Sun, 09 Apr 2006 18:34:26 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18548>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Since I didn't succeed in importing a (private) SVN repo into git, I
wrote a new converter to handle more cases like:

  - use command line svn instead of some perl library to have less
    dependancies and to support proxy + repo authentification.
    Might even work on MacOSX ;)
  - automatic merge detection by looking at from which revision a
    revision gets its files
  - visualisation of the branch tree with dotty to check what git-convert
    would produce _before_ importing it.
  - /trunk is moved to /branches/old, /branches/new_branch becomes /trunk
    in next revision (ARGH!)
  - To be able to continue after a ^C and be able to continue where
    it stopped.
  - have configurable repo layout to handle things like:
    - files next to branches in /branches
    - /branches/

Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-svnconvert.rb"

#!/usr/bin/env ruby

# Convert a Subversion repository with all its branches
# into git incrementally.
#
# The main difference with git-svnimport is
# that it handles a badly-broken archive which I wanted to 
# convert which git-svnimport did not handle ;)
#
# But, of course, your milage may (will!) vary. svn only defines
# snapshot-trees and interpretation of each leaf in the tree is left
# as an exercise for the reader.
#
# Features:
#  - import _all_ branches
#  - uses svn command line, so:
#    - supports HTTP proxy with authentification
#    - supports repository authentification
#    - supports incorrect (self-signed) SSL certificates ;)
#  - can handle multiple branche changes in one revision
#  - supports extra files in /branches next to real branches
#  - gets merge information by looking at which revisions we're based on
#    (so no need to parse commit messages)
#    This (only) works when the merge of two branches results
#    in files from both branches.
#  - handles missing revisions
#  - no extra packages needed, just ruby and subversion.
#  - outputs GraphViz .dot files for visualisation of branches
#  - fairly interrupt-save. Once in a while it saves it state
#    to be able to continue next time where it left off.
#  - works parallel: one process fetches, while another copies
#    it into git.
# Con:
#  - needs a complete, checked-out SVN repository locally
#    _for_ _each_ _branch_.
#    This takes disk space. However, disk space is cheap ;)
# TODO:
#  - parse XML as XML instead of text. In case the exact XML formatting
#    changes in the future...
#  - add tagging support
#  - handle file properties like execute and ignore
#  - use 'svn switch' to checkout other branches fast
#
# Workings
#  - Get a log of all commits
#  - Create a branches graph from this log
#  - Check out each revision separately and write a commit
#    for each revision.
#
# (c)2006 R. Nijlunsing <git-svnconvert@tux.tmfweb.nl>
# Released under the GNU Public License, version 2.


$VERBOSE = true			# Let Ruby warn more

require 'set'
require 'time'
require 'find'
require 'fileutils'
require 'optparse'
require 'cgi'			# For unescapeHTML()

#################### Configuration

# Root directories of the branches and trunk(s).
#   - one line per directory
#   - '*' matches one filename component and is matched last
#   - names are case sensitive
#   - whitespaces at start and end are ignored
$branch_dirs = %q{
  /branches/*
  /branches/cc_test/*
  /branches/pre-dev/trunk
  /branches/pre-dev/trunk_old
  /branches/tasks/*
  /trunk
}

# List of paths which might get matched by $branch_dirs,
# but which are not the root of branches.
#
# Argh. People put files into the root of branches,
# which ends up as a branch (so for example /branches/README
# ends up as a branch). List here all files in the roots
# to ignore them.
$not_branch_dirs = %q{
  /branches/README
  /branches/pre-dev
  /branches/cc_test
  /branches/tasks
}

#################### End of configuration

def read_svn_authors(authors_filename)
  users = {}
  begin
    IO.foreach(authors_filename) { |line|
      if line =~ %r{^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$}
	user, name, email = $1, $2, $3
	users[user] = [name, email]
      end
    }
  rescue Errno::ENOENT, Errno::EACCES
    die("Could not read #{authors_filename}: #{$!}")
  end
  if $verbose
    puts "Read #{users.size} authors from #{authors_filename}"
  end
  return users
end

def write_svn_authors(users, authors_filename)
  begin
    File.open(authors_filename, "wb") { |io|
      users.keys.sort.each { |user|
	io.puts "#{user} = #{users[user][0]} <#{users[user][1]}>"
      }
    }
    if $verbose
      puts "Wrote #{users.size} authors to #{authors_filename}"
    end
  rescue Errno::EACCES
    die("Could not write #{authors_filename}: #{$!}")
  end
end

# Given a string with on each line a root directory, generate a regular
# expression matching one of those root directories.
def root_dirs_to_regexp(rootdirs, is_prefix)
  Regexp.new(
    "^(?:" +			# Match at start without capturing
    rootdirs.
      split("\n").
      find_all { |dir| dir.strip != "" }.	# Delete empty lines
      collect { |dir|
        # make path absolute; use '/' as path separator;
        ("/" + dir.strip).gsub(%r{[\\/]+}, "/")
      }.sort { |dir1, dir2|
        # Sort on size so '/branches/development/trunk' comes before
        # '/branches/*' and will therefore be matched.
        dir2.size <=> dir1.size
      }.collect { |dir|
        Regexp.escape(dir)	# Escape everything
      }.join("|").gsub("\\*", "[^/]+") + # Unescape '*' back
    ")" +
    # If not a prefix, must match at end
    # If prefix, must match at path delimiter (or at end)
    (is_prefix ? "(?=/|$)" : "$")  
  )
end

# Execute shell command; bail out at error
def safe_system(cmd)
  puts cmd if $verbose
  system(cmd)
  if $? != 0
    puts cmd if !$verbose
    puts "!!! Command returned non-zero exit code: #{$?}"
    puts "!!! Working dir: #{Dir.pwd}"
    exit $?
  end
end

def safe_popen(cmd, mode = "w+", &callback)
  puts "|" + cmd if $verbose
  res = IO.popen(cmd, mode, &callback)
  if $? != 0
    puts cmd if !$verbose
    puts "!!! Command returned non-zero exit code: #{$?}"
    puts "!!! Working dir: #{Dir.pwd}"
    exit $?
  end
  return res
end

module Shell
  # Escape string string so that it is parsed to the string itself
  # Compare to Regexp.escape .
  def self.escape(string)
    string !~ %r{[ "\\]}i ? 
      string : '"' + string.gsub(%r{(["\\])}i, '\\\\\1') + '"'
  end
end

def svn_common_args(branch = "")
  repo_url = $repo_url
  repo_url += "/" + branch if branch != ""
  res = "--non-interactive"
  res += " --username #{Shell.escape($username)}" if $username
  res += " --password #{Shell.escape($password)}" if $password
  res += " #{Shell.escape(repo_url)}"
  res
end

def svn_get_current_revision
  $stderr.print "Retrieving current HEAD revision... " if $verbose
  # 'svn info' doesn't always work to get most recent revision.
  # So parse output of 'svn log -r HEAD:HEAD'.
  svn_info = `svn log --xml -r HEAD:HEAD #{svn_common_args}`
  svn_info =~ %r{\srevision=\"(\d+)\"}m
  $stderr.puts "r#{$1}" if $verbose
  $1.to_i
end

# Prefix each line with "!!!" and only warn:
#  - once for each unique warning
#  - at most a fixed number of times per caller
$warning_txt = Set.new		# All dumped warnings texts
$warning_callers = {}		# Per caller: number of warnings
def warning(*txt)
  txt = txt.flatten.collect { |t| t.split("\n") }.flatten
  if !$warning_txt.include?(txt)
    $warning_txt << txt
    backtrace = caller[0]
    $warning_callers[backtrace] ||= 0
    times_warned = ($warning_callers[backtrace] += 1)
    if times_warned <= 5
      first = true
      txt.each { |line|
	$stderr.puts((first ? "!!!" : "   ") + " #{line}")
	first = false
      }
      if times_warned == 5
	$stderr.puts 
          "    (more of this type of warnings will be suppressed)"
      end
    end
  end
end

def die(*txt); warning(*txt); exit 1; end

class BranchColor
  @@available_colors = [
    "green", "yellow", "orange", "cyan", "steelblue3",
    "lightblue", "thistle", "red", '".7 .3 1.0"',
    "navy", "violet", "crimson", "azure", "linen", "peru",
    "tan", "darkgreen", "coral"
  ]
  @@branch_color = {}		# String branch -> String color

  def self.color(branch)
    # For a new branch, take a fixed color or a random one if out-of-colors.
    @@branch_color[branch] ||= (
      @@available_colors.shift ||
      ('"%.1f %.1f %.1f"' % [rand + 0.1, rand + 0.1, rand + 0.1])
    )
  end
end

# Map a filename into a branch name part and element name part.
# Branchname may contain '/''s.
# Element name starts with a '/' or is empty.
#
# SVN does not contain branches, but only contains one large tree with
# objects of (potentially different) versions. By only looking at a
# subtree, a branch is emulated. However, we have to know where those
# subtrees are rooted to be able to convert them to branches.
def path_to_branch(filename)
  if filename =~ $branch_dirs
    # We matched a branch-name.
    branch, elem = $&, filename[$&.size..-1]
    return nil if branch =~ $not_branch_dirs
    return [branch[1..-1], elem] # Remove leading '/' from branch name
  else
    # Outside the branches (e.g. a tag). Skip this.
    return nil
  end
end

# Revision of a branch; part of a revision.
# Forms a directed acyclic graph with other BranchRevisions
class BranchRevision
  attr_accessor :must_add_implicit_dep	# Boolean
  attr_accessor :depends_on	# Set of BranchRevision: parents
  attr_accessor :dependers      # Set of BranchRevision: children
  attr_reader :branch		# String: branchname
  attr_accessor :empty		# Bool: true if no reason to keep this rev
  attr_accessor :deleted	# Bool: true if deleted at end
  attr_accessor :commit_sha1	# String. git's SHA1 commit hash.

  # If true, implicitly adds an dependancy on the previous
  # version of this branch. This the the default.
  # However, when we detect that this branch consists of totally new files
  # (for example, when copying /trunk to /branches/branch_name) we set
  # this to false.
  # @must_add_implicit_dep  # Boolean

  def initialize(revision, branch)
    @revision = revision	# Revision
    @branch = branch
    @must_add_implicit_dep = true
    @depends_on = Set.new
    @dependers = Set.new
    @empty = true
    @deleted = false
    @commit_sha1 = nil
  end

  # Compare on revision number
  def <=>(other); self.nr <=> other.nr; end

  def to_s; "#{@branch}:#{nr}"; end

  def nr; @revision.nr; end	# Fixnum: revision nr

  # Returns true if this BranchRevision is a root revision since:
  #   - it does not depend on another BranchRevision
  #   - it contains changes _within_ the branch (== not empty)
  def root?; @depends_on.empty? && !@empty; end

  def add_depends_on(branch_rev)
    @depends_on << branch_rev
    branch_rev.dependers << self
  end

  def remove_depends_on(branch_rev)
    @depends_on.delete(branch_rev)
    branch_rev.dependers.delete(self)
  end

  def rev; @revision; end

  def other_branch_depends_on
    @depends_on.find_all { |b| b.branch != @branch }
  end

  # Returns all BranchRevisions we depend on in the same branch
  def same_branch_depends_on
    @depends_on.find_all { |b| b.branch == @branch }
  end

  # Returns branch revision on which we depend which is least number
  # of revisions back on the same branch. Since we go back, this is
  # the max. revision of the dependancies.
  def closest_same_branch_depends_on
    same_branch_depends_on.max
  end

  # Returns branch revision which depends on us which is least number
  # of revisions forward on the same branch.
  def closest_same_branch_depender
    @dependers.find_all { |b| b.branch == @branch }.min
  end

  # A dependancy is unneeded when:
  #   - the dependancy belongs to the same branch and the same revs
  #     can be reached by removed this dependancy, or
  #   - the dependancy belongs to another branch on which a rev in
  #     the same branch above us is already depending
  def remove_unneeded_depends_on
    return if @depends_on.size <= 1 # Optimisation

    # TODO: look farther back.

    # Same branch dependancy remover:
    # Follow the dependancy chain along the closest parent
    # till we reach the farthest dep.
    same_branch_deps = same_branch_depends_on()
    closest_same_branch_dep = same_branch_deps.max
    farthest_same_branch_nr = !same_branch_deps.empty? && same_branch_deps.min.nr
    current_dep = closest_same_branch_dep
    same_branch_deps_rec = Set.new
    while current_dep && current_dep.nr >= farthest_same_branch_nr
      same_branch_deps_rec.add(current_dep)
      current_dep = current_dep.closest_same_branch_depends_on
    end
    same_branch_deps.each { |red_rev|
      if red_rev != closest_same_branch_dep &&
	  same_branch_deps_rec.include?(red_rev)
#	puts "r#{nr}: Dep. on same branch r#{red_rev.nr} redundant" if $verbose
	remove_depends_on(red_rev)
      end
    }

    # Via-other-branch redundant dependancy remover:
    other_branch_depends_on.each { |other_dep|
      if !((other_dep.dependers & same_branch_deps_rec).empty?)
#	puts "r#{nr}: Dep. on other branch r#{other_dep.nr} redundant" if $verbose
	remove_depends_on(other_dep)
      end
    }
  end

  # Signal the fact that the last action has been added to this revision.
  # Now the dependancies can be calculated.
  def last_action_added
    if @must_add_implicit_dep
      prev_branch_rev = Revision.find_revision_with_branch(nr - 1, @branch)
      add_depends_on(prev_branch_rev) if prev_branch_rev
    end
    @depends_on.dup.each { |br|
      # We might depend on empty branch revisions. Since empty branch will not
      # be checked out, copy dependancies from those branches.
      if br.empty
	br.depends_on.each { |parent_depends_on|
	  add_depends_on(parent_depends_on)
	}
	remove_depends_on(br)
      end
    }
    remove_unneeded_depends_on
  end

  # Internal dotty label.
  def label; "_#{@branch}_#{nr}".delete("^0-9a-zA-Z_"); end

  def to_dotty
    return "\t/* r#{nr} is empty */\n" if @empty
    res = "\t#{label}[label=\"#{File.basename(@branch)} " +
      "#{nr}\\n#{rev.author}\",color=#{BranchColor.color(@branch)}];"
    @depends_on.each { |d|
      res += " #{d.label} -> #{label}"
      res += "[style=dashed]" if @branch != d.branch # A merge or branch
      res += ";"
    }
    res + "\n"
  end
end

# One revision in SVN. Contains zero or more BranchRevisions.
class Revision
  attr_reader :nr		# Fixnum
  attr_accessor :author		# String
  attr_accessor :msg		# String
  attr_accessor :time		# String
  attr_accessor :branches	# Hash: String rootdir to BranchRevision

  @@all_revs = []		# Array: all revisions, indexed by nr

  def self.get_all_revs; @@all_revs; end

  def self.set_all_revs(new_all_revs); @@all_revs = new_all_revs; end

  # Returns first revision number we're interested in.
  def self.get_next_log_nr
    @@all_revs[-1] ? @@all_revs[-1].nr + 1 : $start_revision
  end

  def self.[](nr); @@all_revs[nr]; end
  # Iterate sorted over each revision
  def self.each; @@all_revs.each { |rev| yield(rev) if rev }; end

  # Search for most recent BranchRevision which changed given branch.
  def self.find_revision_with_branch(start_nr, branch)
    start_nr.downto($start_revision) { |nr|
      rev = @@all_revs[nr]
      return rev.branches[branch] if rev && rev.branches.has_key?(branch)
    }
    warning(
      "Could not find branch #{branch.inspect} from revision #{start_nr} back"
    ) if start_nr >= $start_revision
    return nil
  end

  def initialize(nr)
    @nr = nr
    @branches = {}
    # Store new revision in global revision array
    @@all_revs[nr] = self
  end

  # Add an action to this revision
  #   'copyto_path' is the destination being changed. In all cases,
  #   this can be a file or directory.
  #   action == :R  : Replace. copyfrom_* always filled in.
  #   action == :M  : Modify
  #   action == :D  : Delete
  #   action == :A  : Create as new or copy from other revision
  #                   If from other revision, copyfrom_* are filled in.
  $branch_paths = Set.new
  def add_action(action, copyto_path, copyfrom_path, copyfrom_rev)
    branch, elem = *path_to_branch(copyto_path)
    return if !branch		# Action is outside a branch

    if $verbose && !$branch_paths.include?(branch)
      puts "r#{nr}: New branch: #{branch}"
      $branch_paths.add(branch)
    end

    branch_rev = (@branches[branch] ||= BranchRevision.new(self, branch))

    from_branch = from_elem = nil
    if copyfrom_path
      from_branch, from_elem = *path_to_branch(copyfrom_path)
      if !from_branch
	# Not a branch. Must be a tag.
	warning(
          "Ignoring dependancy r#{@nr} on a non-branch: " + 
          "#{copyfrom_path.inspect}:#{copyfrom_rev}"
        )
      else
	from_branch_rev = 
	  Revision.find_revision_with_branch(copyfrom_rev, from_branch)
	branch_rev.add_depends_on(from_branch_rev) if from_branch_rev
      end
    end

    # We cannot checkout deleted branches, so record the fact that
    # it is deleted at the end of the revision.
    branch_rev.deleted = true if elem == "" && action == :D

    # If something changes the root of the branch (deleted, copied
    # from other branch, ...) we break the implicit dependancy chain.
    # However, _modifying_ the root directory (adding files, removing files)
    # does not remove the dependancy.
    branch_rev.must_add_implicit_dep = false if elem == "" && action != :M

    # Check whether this action results in a revision. For example,
    # deleting the root of the branch or creating the root dir does not
    # change anything _within_ the branch.
    branch_rev.empty = false if elem != "" # Real files. Not empty.
  end

  # Signal the fact that the last action has been added to this revision.
  # Now the dependancies can be calculated.
  def last_action_added
    @branches.each_value { |b| b.last_action_added }
  end

  def to_dotty
    @branches.values.collect { |b| b.to_dotty }.join("")
  end
end

# Parse output of 'svn log --xml --verbose'
def parse_svn_log_xml(svnlog_filename)
  $stderr.puts "Branch analysis on svn log files..." if $verbose
  last_rev_nr = nil
  rev = nil			# Current Revision
  File.open(svnlog_filename, "rb") { |io|
    while line = io.gets
      case line
      when %r{^   revision="(\d+)"}
	rev_nr = $1.to_i
	$stderr.print "r#{rev_nr}" + ("\010" * 10)
	# Only create a new revision when not already loaded from
	# state file.
	if rev_nr > $start_revision && Revision[rev_nr] == nil
	  rev = Revision.new(rev_nr)
	  if last_rev_nr && (rev_nr != last_rev_nr + 1)
	    # Missing revisions are a sign of not getting the log of the
	    # whole archive, but only one of its branches (or subprojects).
	    # Which could be valid if we're after a subproject, but not
	    # if we want to import the whole repository.
	    warning("Missing reversion(s) #{last_rev_nr + 1}-#{rev_nr - 1}")
	  end
	  last_rev_nr = rev_nr
	end
      when %r{^\<path}: copyfrom_path = nil; copyfrom_rev = nil
      when %r{^   copyfrom-path="(.*)"}: copyfrom_path = $1
      when %r{^   copyfrom-rev="(\d+)"}: copyfrom_rev = $1.to_i
      when %r{^   action="([A-Z])"\>(.*)\</path\>}
	rev.add_action($1.to_sym, $2, copyfrom_path, copyfrom_rev) if rev
      when %r{^\</paths\>}
	# End of this revision.
	next if !rev
	rev.last_action_added
	root_branches = rev.branches.values.find_all { |branch| branch.root? }
	root_branches.each { |bi|
	  puts "r#{rev.nr} is root of #{bi.branch}"
	}
	changed_branches = rev.branches.values.find_all { |b| !b.empty }
	if changed_branches.size > 1
	  changed_branches_names = changed_branches.collect { |b| b.branch }
	  warning(
            "More than one branch changed in r#{rev.nr}..?",
            changed_branches_names
          )
	end
      when %r{^\<author\>(.*)\</author\>}
	rev.author = $1 if rev
      when %r{^\<msg\>(.*)}
	msg = $1.rstrip
	while !msg.gsub!("\</msg\>", "")
	  msg += "\n" + io.gets.rstrip
	end
	msg = CGI::unescapeHTML(msg.strip + "\n") # &amp; -> & etc.
	rev.msg = msg if rev
      when %r{^\<date\>(.*)\</date\>}
	rev.time = Time.parse($1) if rev
      end
    end
  }
end

$state_version = "20060409"

# Load state of git-svnconvert. Returns true in case of succes.
def load_state
  begin
    state = File.open($state, "rb") { |io| Marshal.load(io) }
    version = state.shift
    if version != $state_version
      warning(
        "Ignoring previous state: has different version (#{version}) " +
        "than this git-svnconvert version (#{$state_version})"
      )
    else
      $repo_url, all_new_revs = *state
      Revision.set_all_revs(all_new_revs)
      return true
    end
  rescue Errno::ENOENT
  end
  return false
end

def save_state
  start_time = Time.now
  File.open($state + ".new", "wb") { |io|
    io.write(Marshal.dump([$state_version, $repo_url, Revision.get_all_revs]))
  }
  # Rename atomically new state into _the_ state
  File.rename($state + ".new", $state)
  $stderr.puts "Saved new state in %.1fs" % (Time.now - start_time) if $verbose
end

# Export current graph of revisions to a GraphViz dotty file
def export_to_dot(dot_file)
  $stderr.puts "Writing branch graph to \"#{dot_file}\"..."
  File.open(dot_file, "wb") { |io|
    io.puts "strict digraph svn {"
    io.puts "\tnode[shape=box,style=filled];\n\n"
    Revision.each { |rev|
      next if !rev || (rev.nr < $start_revision)
      io.print rev.to_dotty
    }
    io.puts "}"
  }
end

# Runs an svn command, and run git-update-index on each file
# echoed to stdout by svn.
def svn_cmd_with_update_index(svn_cmd)
  safe_popen(svn_cmd, "r") { |svn_io|
    safe_popen("git-update-index --add --remove --stdin", "w") { |git_io|
      git_io.sync = true
      # Have a buffer of one line: svn echoes the file it is
      # working on. When svn echoes the next line, we then know
      # it finished the previous file, and can therefore be added
      # to git now.
      last_file = nil
      while line = svn_io.gets
	$stderr.puts line if $verbose
	if line =~ %r{^[A-Z][A-Z ]{3} (.*)$}
	  git_io.puts last_file if last_file 
	  last_file = $1
	end
      end
      git_io.puts last_file if last_file 
    }
  }
end

# Unknown contents in directory; recreate index
def git_update_index
  # Remove incomplete index
  git_index_file = ENV['GIT_INDEX_FILE']
  [git_index_file, git_index_file + ".lock"].each { |f|
    File.delete(f) if File.exist?(f)
  }
  # Add all files
  to_prune = Set.new([".git", ".svn"]) # Directories not to add
  safe_popen("git-update-index --add --remove --stdin") { |io|
    elems = 0
    Find.find(".") { |elem|
      Find.prune if to_prune.include?(File.basename(elem))
      if elem != "."
	elem = elem[2..-1]  # Remove ./
	io.puts elem
	elems += 1
      end
    }
    puts "Dir contained #{elems} elements" if $verbose
  }
end

######################################## Main

# Default values for options
$verbose = true
$username = nil			# Repository username
$password = nil			# Repository password
$start_revision = 1
dot_filename = nil
svn_authors_file = nil		# Mapping from 
$run_dotty = false

# Parse options
$opts = OptionParser.new
$opts.banner = %q{Convertor for a subversion archive into a git archive.

git-svnconvert [options] URL[@REV] [DIR]
  ..to convert complete SVN archive at URL into directory DIR.
  The URL must point to the root directory of the repo, so not f.e. to /trunk!
  By default, DIR will be the basename of the URL.
  Directory DIR will be created if it does not exist.
  Otherwise, DIR must already be a git repository.
git-svnconvert [options]
  ..to incrementally convert newly added revision and add them
    to the git repo in the current directory.

Examples:

git-svnconvert svn://svn.0pointer.net/fusedav .
  ..checks out svn://svn.0pointer.net/fusedav into current dir.
git-svnconvert svn://svn.0pointer.net/fusedav@10
  ..checks out starting at revision 10 into directory fusedav.
git-svnconvert
  ..updates already imported svn archive in current dir.

}
$opts.on("Options (defaults between []'s):")
$opts.on("--verbose", "-v", "Toggle verbose mode [#{$verbose}]") {
  $verbose = !$verbose
}
$opts.on("--help", "-h", "This usage") { puts $opts; exit 1 }
$opts.on("--revision REV", "-s", "Start revision [#{$start_revision}]") {
  |$start_revision|
}
$opts.on("--dot FILENAME", "-d", "Export branch tree as .dot file.") {
  |dot_filename|
}
$opts.on("--dotty", "-D", "Export branch tree and run dotty on it") {
  $run_dotty = true
}
$opts.on("--authors FILENAME", "-A", "Filename of svnauthors file to add") {
  |svn_authors_file|
}
$opts.on("\nOptions passed to 'svn':");
$opts.on("--username NAME", "-u", "Specify a username for SVN repo") {
  |$username|
}
$opts.on("--password PWD", "-p", "Specify a password for SVN repo") {
  |$password|
}

begin
  $opts.parse!(ARGV)
rescue OptionParser::InvalidOption
  die($!.to_s, $opts.to_s)
end

$repo_url = (ARGV.size > 0) ? ARGV.shift.dup : nil
# Parse @REV part of URL@REV if given...
$start_revision = $1.to_i if $repo_url && $repo_url.gsub!(%r{@(\d+)$}, "")
dest_dir = (ARGV.size > 0) ? ARGV.shift : nil
dest_dir = File.basename($repo_url) if $repo_url && !dest_dir
dest_dir ||= Dir.pwd	# No URL and no destdir given: use current dir
dest_dir = File.expand_path(dest_dir)
git_dir = ENV["GIT_DIR"] || "#{dest_dir}/.git"
svnconvert_dir = "#{git_dir}/svnconvert"
# Name of state file with all parsed log files and connection to git archive.
$state = "#{svnconvert_dir}/state"

if !File.exist?($state) && !$repo_url
  puts $opts.to_s
  puts "\n!!! Need an URL to checkout or a previously git-svnconvert'ed dir"
  exit 1
end

# Maping from SVN author name to full name and email
default_svn_authors_file = "#{git_dir}/svn-authors"
users = File.readable?(default_svn_authors_file) ?
  read_svn_authors(default_svn_authors_file) : {}
# If authors file explicitly given, add
if svn_authors_file
  users_to_add = read_svn_authors(svn_authors_file)
  if users_to_add.size > 0
    users.merge!(users_to_add) 
    write_svn_authors(users, default_svn_authors_file)
  end
end

FileUtils.mkdir_p(svnconvert_dir)	# Create destination if not existing
Dir.chdir(dest_dir)

$branch_dirs = root_dirs_to_regexp($branch_dirs, true)
$not_branch_dirs = root_dirs_to_regexp($not_branch_dirs, false)

# Load complete state, or failing that, same empty state with new repo URL
load_state || save_state
next_revision_nr = Revision.get_next_log_nr
if next_revision_nr < svn_get_current_revision
  svnlog = "#{svnconvert_dir}/svnlog.xml"
  puts "Retrieving revision log from #{next_revision_nr} and upwards..."
  cmd = "svn log #{svn_common_args} -r #{next_revision_nr}:HEAD --xml --verbose >#{svnlog}"
  safe_system(cmd)
  parse_svn_log_xml(svnlog)
  save_state
else
  puts "No new revision to get log of."
end

# The graph eases debugging, so export it always...
default_dot_filename = "#{svnconvert_dir}/branches.dot"
export_to_dot(dot_filename || default_dot_filename)
if $run_dotty
  safe_system("dotty #{Shell.escape(dot_filename || default_dot_filename)}")
end
exit 0 if dot_filename || $run_dotty

# Directory of all branches checked out:
svn_co_dir = "#{svnconvert_dir}/checkedout" 
ENV['GIT_DIR'] = git_dir

head_existed = File.exist?("#{git_dir}/HEAD")
safe_system("git-init-db")
if !head_existed
  $stderr.puts "Creating HEAD pointing to trunk"
  File.open("#{git_dir}/HEAD", "wb") { |io|
    io.puts "ref: refs/heads/trunk"
  }
end
Revision.each { |rev|
  next if rev.nr < $start_revision

  rev_commit_sha1s = []
  branches = rev.branches.values
  branches.each { |br|
    branch_dir = "#{svn_co_dir}/#{br.branch}"
    if br.commit_sha1
      # Skip if already imported
    elsif br.deleted
      # Branch contains only an 'delete this branch' command.
      $stderr.puts "r#{rev.nr}: #{br.branch} deleting #{branch_dir}"
#      FileUtils.rm_rf(branch_dir)
    elsif br.empty
      $stderr.puts "r#{rev.nr}: #{br.branch} is empty; skipping..."
    else
      # Hide the git index inside .svn dir.
      git_index_file = ENV['GIT_INDEX_FILE'] = "#{branch_dir}/.svn/index.git"
      if !File.directory?(branch_dir)
        # Start of new branch. Make (empty) directory to start new branch in
        FileUtils.mkdir_p(branch_dir)
	FileUtils.mkdir_p(File.dirname(ENV['GIT_INDEX_FILE']))
	Dir.chdir(branch_dir)
        puts "Checking out new branch #{br.branch}:#{rev.nr} in #{Dir.pwd}"
        cmd = "svn checkout -r #{rev.nr} #{svn_common_args(br.branch)} ."
        svn_cmd_with_update_index(cmd)
      else
	# Branched already checked out, update to new revision.
	Dir.chdir(branch_dir)
	svn_cmd = "svn update -r #{rev.nr} ."
	if File.exist?(git_index_file + ".lock")
	  $stderr.puts "Git index file already locked. Removing lock and recreating index."
	  safe_system(svn_cmd)
	  git_update_index
	else
	  puts "Updating branch to new revision: #{br.branch}:#{rev.nr}"
	  svn_cmd_with_update_index(svn_cmd)
	end
      end

      # git index is now up-to-date. Write the tree.
      tree_sha1 = `git-write-tree`.chomp

      # Now write this tree into an commit
      author = rev.author
      email = "unknown"
      author, email = users[author] if users[author]
      $stderr.puts "r#{rev.nr}: Author: #{author} <#{email}>" if $verbose
      ENV['GIT_AUTHOR_NAME'] = ENV['GIT_COMMITTER_NAME'] = author
      ENV['GIT_AUTHOR_EMAIL'] = ENV['GIT_COMMITTER_EMAIL'] = email
      ENV['GIT_AUTHOR_DATE'] = ENV['GIT_COMMITTER_DATE'] =
	rev.time.strftime("+0000 %Y-%m-%d %H:%M:%S") 
      parents = br.depends_on.find_all { |p|
	# Filter out all non-converted parents
	raise if !p.commit_sha1 && p.nr >= $start_revision
	p.commit_sha1 != nil
      }.collect { |p| "-p #{p.commit_sha1}" }.join(" ")
      puts "Committing #{tree_sha1}..."
      cmd = "git-commit-tree #{tree_sha1} #{parents}"
      puts cmd if $verbose
      safe_popen(cmd) { |io|
        io.puts rev.msg.strip
        io.close_write
        br.commit_sha1 = io.read.chomp
        rev_commit_sha1s << br.commit_sha1    
      }
      puts "#{br.branch}:#{rev.nr} has id #{br.commit_sha1}" if $verbose

      Dir.chdir(dest_dir)
      # Tag current branch + revision.
#    safe_system("git-tag -f #{br.branch}/r#{rev.nr} #{br.commit_sha1}")
      # Update HEAD of this branch
      safe_system("git-update-ref refs/heads/#{br.branch} #{br.commit_sha1}")
      puts
    end
  }
  if rev_commit_sha1s.size == 1
    # '-f' added to make this script restartable (state might not get saved)
    safe_system("git-tag -f r#{rev.nr} #{rev_commit_sha1s}")
  end
  save_state if !rev_commit_sha1s.empty?
}
puts "Done."

--GvXjxJ+pjyke8COw--
