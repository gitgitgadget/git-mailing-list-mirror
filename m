From: Rutger Nijlunsing <rutger@nospam.com>
Subject: [ANNOUNCE] ClearCase UCM -> git converter
Date: Thu, 6 Jul 2006 19:36:15 +0200
Organization: M38c
Message-ID: <20060706173615.GA7395@nospam.com>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
X-From: git-owner@vger.kernel.org Thu Jul 06 19:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyXm3-0004lZ-Dx
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 19:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWGFRgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 13:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWGFRgU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 13:36:20 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:61656 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1030352AbWGFRgT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 13:36:19 -0400
Received: from wingding.demon.nl ([82.161.27.36]:55219)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FyXlx-000OO8-5l
	for git@vger.kernel.org; Thu, 06 Jul 2006 17:36:17 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FyXlv-00024x-TP
	for git@vger.kernel.org; Thu, 06 Jul 2006 19:36:16 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23399>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Find attached a ClearCase UCM -> git converter.

While UCM does have branches and so on, this importer imports one
stream. Since UCM is somewhat like an expensive CVS, it is quite
difficult to retrieve more information from UCM in a useful way: the
concept are just too poluted.

Features:
  - Author files support to map ClearCase usernames to git user names
  - Incrementally import one ClearCase UCM stream into git.
    Just rerun the script when new baselines were created.
  - Handles composite baselines
  - Auto-detection of VOB, stream, rules to load, .. as much
    as possible.
  - Auto repack after a lot of objects have been generated
  - Should be able to pick up where it left after an interruption.

HOWEVER, it is Windows only currently since I don't have a cleartool
unix client. It should not be too hard to convert though, since it
uses the normal 'cleartool' command line client to retrieve all
information.

Usage:

Just have your stream-to-be-converted running at, say, m:\mystream_int
(most likely an integration stream), and say something like:

	git-ucmimport m:\mystream_int c:\mystream_git

...and hopefully it should detect all configuration items and start
converting.

Can also be found at http://www.wingding.demon.nl .

Rutger.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-ucmimport.rb"

#!/usr/bin/env ruby

# ClearCase UCM -> git importer.
#
# Imports the baselines of _one_ stream into a Git repository.
#
# Features:
#   - Author files support to map ClearCase usernames to git user names
#   - Incrementally import one ClearCase UCM stream into git.
#     Just rerun the script when new baselines were created.
#   - Handles composite baselines
#   - Auto-detection of VOB, stream, rules to load, .. as much
#     as possible.
#   - Auto repack after a lot of objects have been generated
#   - Should be able to pick up where it left after an interrruption.
#
# Assumptions:
#   - Works on Windows for me(TM). Not tested on Unix.
#
# Discussion:
# Importing the whole tree of streams (branches) of UCM into git is
# next to impossible. UCM has the concepts of 'activities' which
# contain versions of changed files, and a set of activities is
# delivered as a changeset. So far so good. However, activities may be
# reused (even over changeset boundary) and may be interleaved with
# each other. This makes it infeasible to map activities or changesets
# on git commits, which is a much nicer concept.
#
# 2006 Rutger Nijlunsing <git-ucmimport@tux.tmfweb.nl>

############################## Config documentation.
# Don't change those; just use the command line switches to set them.
# Section below is mainly for documentation purposes. ;)

# ClearCase: Directory with existing Dynamic view on integration
# stream to import. Probably a subdirectory on M:\, or under /view
$int_view_dir = ""

# Location of snapshot view on substream of integration stream. We are
# going to rebase this stream to a newer version in int_view, and then
# check in the result.
$sub_view_dir = ""

# Baseline in parent stream to start importing at if the destination
# snapshot view does not exist.
# If empty, takes first baseline.
# Use 'cleartool lsbl' in stream directory to get a list.
first_baseline = ""

# Subdirectory of $sub_view_dir to generate git repository at.  Only
# files in this directory or lower are added. This can be used when a
# common subdirectory is always added to the paths (which is common in
# ClearCase). If unsure, leave empty.
$sub_root = ""

# Filename with author mapping from ClearCase to Git. Leave empty ("")
# to have no mapping and use the ClearCase names.
# Format of file is lines containing:
#   'cc_author_name=Real Name <email@domain.com>'
$ucm_authors_file = ""

# Server Storage Location for the view storage directory.
# This is the same as can be found in the GUI:
#   ClearCase Explorer -> Join Project -> Next -> Next -> Next ->
#     Advanced Options -> [x] Use server storage location,
# and then the 'name' column of that table.
# Use empty string ("") for default.
stgloc = "ADVIEWS"

##############################

# Include required standard Ruby libraries
require 'find'
require 'fileutils'
require 'time'
require 'optparse'
require 'ostruct'

$VERBOSE = true
$verbose = true

def die(*txt); puts txt.flatten.join("\n"); exit 1; end

def read_ucm_authors(authors_filename)
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

def write_ucm_authors(users, authors_filename)
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

def read_write_ucm_authors
  # Maping from ClearCase author name to full name and email
  default_ucm_authors_file = "#{$git_dir}/ucm-authors"
  $users = File.readable?(default_ucm_authors_file) ?
  read_ucm_authors(default_ucm_authors_file) : {}
  # If authors file explicitly given, add
  if $ucm_authors_file && $ucm_authors_file != ""
    users_to_add = read_ucm_authors($ucm_authors_file)
    if users_to_add.size > 0
      $users.merge!(users_to_add) 
      write_ucm_authors($users, default_ucm_authors_file)
    end
  end
end

module Shell
  # Escape string string so that it is parsed to the string itself
  # Compare to Regexp.escape .
  def self.escape(string)
    (string !~ %r{[ "]}i && string != "") ? 
      string : '"' + string.gsub(%r{(["])}i, '\\\\\1') + '"'
  end if not defined? self.escape
end

# Run 'cleartool' and filter the output.
def system_filter_output(cmd, may_fail)
  no_merge_required = false
  hijacked = []
  p cmd
  File.popen("#{cmd} 2>&1", "rb") { |io|
    while line = io.gets
      line = line.rstrip
      next if line =~ %r{^[.]*$}
      next if line =~ %r{^End dir }
      next if line =~ %r{^Processing dir }
      next if line =~ %r{^Done loading }
      next if line =~ %r{^Log has been written to }
      next if line =~ %r{^Making dir } # Only interested in files...
      line = line.
	sub(%r{^Loading }, "+ ").
	sub(%r{^Unloaded }, "- ")
      no_merge_required = true if line =~ %r{^No versions require merging}
      if line =~ %r{^Keeping hijacked object "(.*)"}
	hijacked << $1
      else
	raise if line =~ %r{hijacked}
      end
      puts line
    end
  }
  # Some hijacked files might be left. Update them manually
  hijacked.each { |f|
    puts "Unhijacking #{f}"
    safe_system("cleartool update -overwrite #{Shell.escape(f)}")
  }
  ok = no_merge_required
  if !ok && !may_fail
    die(
	"!!! View at #{Dir.pwd} is not clean.",
	"!!! No checkout out files, hijacked files etc. may be present.",
	"!!! Restore the view (undo hijacking, undo checkouts etc.) and retry."
    )
  end
  return ok
end

def skip(*cmd); puts "Skipping #{cmd.inspect}"; end

# Run a command with its arguments.
# When cmd is an array, a boolean indicates whether the next argument should
# be emitted or not.
def safe_system(*cmd)
  emit = true
  cmdline = [cmd].flatten.collect { |arg|
    if (arg == true) || (arg == false)
      emit = arg
      arg = nil
    else
      arg = nil if !emit
      emit = true
    end
    arg.to_s
  }.join(" ")
  puts cmdline if $verbose
  system(cmdline)
  if $? != 0
    puts cmdline if !$verbose
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

# Returns all rules loaded in the current directory
def read_loaded_rules
  rules = {}
  File.popen("cleartool catcs", "rb") { |io|
    while line = io.gets
      rules[$1] = true if line =~ %r{^element "\[[0-9a-f]{32}=(.*)\].*\" }
    end
  }
  rules = rules.keys
  return rules
end

class Activity
  attr_accessor :id, :author, :comment

  def is_activity; @id !~ %r{^(deliver|rebase)\.}; end

  def initialize(id, author, comment)
    @id = id
    @author = author
    @comment = comment
  end

  def hash; @id.hash; end
  def eql?(other); @id == other.id; end
end

# A baseline of a stream
class Baseline
  attr_reader :name		# Name of baseline
  attr_reader :date		# Date of creation of baseline
  attr_reader :author		# User who created the baseline
  attr_reader :comment
  attr_reader :children		# For composite baselines
  attr_reader :parent		# For non-composite baselines
  attr_accessor :component	# String

  def initialize(name, date, author, comment)
    @name = name
    @date = date
    @author = author
    @comment = comment
    @children = []
    @parent = nil
  end
  
  def set_parent(b); @parent = b; b.add_child(self); end
  def add_child(baseline); @children << baseline; end

  # Returns self and all children (recursively)
  def children_recursive
    res = [self]
    children.each { |c| res += c.children_recursive }
    return res
  end
end

# Make sure .git exists and save the state
def git_init_db
  Dir.chdir($git_root)
  if !File.directory?($git_dir)
    puts "\n=== Creating initial git repository at #{$git_root}"
    safe_system("git init-db")
    if !File.directory?($git_dir)
      die("!!! Could not create git repo at #{$git_root}")
    end
  end
  save_state
end

def git_commit(baseline, msg)
  Dir.chdir($sub_view_dir)
  puts "\n=== Removing ClearCase left-over files..."
  Find.find(".") { |elem|
    if elem =~ %r{\.(contrib|keep|renamed|unloaded|loading|mkelem)(\.\d+)?$} ||
	elem =~ %r{\.(updt|stackdump)$}
      puts "Removing #{elem}"
      FileUtils.rm_rf(elem)
    end
  }

  Dir.chdir($git_root)
  puts "\n=== Adding files to git"
  safe_system("git add .")

  author = baseline.author
  email = nil
  author, email = $users[author] if $users[author]
  author ||= "unknown"
  email ||= "unknown"

  ENV['GIT_AUTHOR_NAME'] = ENV['GIT_COMMITTER_NAME'] = author
  ENV['GIT_AUTHOR_EMAIL'] = ENV['GIT_COMMITTER_EMAIL'] = email
  date = baseline.date
  if date
    puts "Date: #{date}"
    ENV['GIT_AUTHOR_DATE'] = ENV['GIT_COMMITTER_DATE'] =
      date.strftime("+0000 %Y-%m-%d %H:%M:%S")
  else
    ENV.delete('GIT_AUTHOR_DATE')
    ENV.delete('GIT_COMMITTER_DATE')
  end

  puts "\n=== Committing new version to git"
  puts "Commit message:"
  puts msg
  # 'git commit' might fail if no data is added, so no safe_popen()
  cmd = "git commit --no-verify -F - --all"
  File.popen(cmd, "wb") { |io|
    io.print msg
  }

  puts "\n=== Tagging baseline in git"
  system("git tag -f #{baseline.name}")
end

$state_version = "20060706"

# Load state. Returns true in case of succes.
def load_state
  begin
    state = File.open($state, "rb") { |io| Marshal.load(io) }
    if state.version != $state_version
      die(
        "!!! Previous state has different version (#{state.version}) ",
        "!!! than this git-ucmimport version (#{$state_version})"
      )
    else
      $int_view_dir = state.int_view_dir
      $sub_view_dir = state.sub_view_dir
      $sub_root = state.sub_root
      return true
    end
  rescue Errno::ENOENT
  end
  return false
end

def save_state
  File.open($state + ".new", "wb") { |io|
    state = OpenStruct.new
    state.version = $state_version
    state.int_view_dir = $int_view_dir
    state.sub_view_dir = $sub_view_dir
    state.sub_root = $sub_root
    io.write(Marshal.dump(state))
  }
  # Rename atomically new state into _the_ state
  File.rename($state + ".new", $state)
end

######################################## Start of main

# Make sure Cygwin is in front of path. Otherwise we might fail
# if other Unix toolkits (like NutCracker) are simultanously installed.
ENV['PATH'] = "c:\\cygwin\\bin;" + ENV['PATH']

$state = ".git/git-ucmimport.state"
state_loaded = false
state_loaded ||= load_state if File.exists?($state)

puts "ClearCase UCM -> git importer"
puts "(c)2006 R. Nijlunsing <git-ucmimport@tux.tmfweb.nl>"
puts "License: LGPL."
puts
$opts = OptionParser.new
$opts.banner = %q{Usage:
  git-ucmimport [dynamic view to import] [dir to export to]
     For the initial conversion.

  git-ucmimport
     From the git repository to incrementally convert.

Example:
  git-ucmimport --authors-file c:\\temp\\authors m:\\jparser_int c:\\jparser_git
  ...to import the stream of view 'jparser_int' which is started at
  m:\\jparser_int into newly-generated stream, view and directory at
  c:\\jparser_git .  c:\\temp\\authors contains the usernames mapping.
  c:\\jparser_git will both be a UCM view as well as an git repo, but will
  be read-only! So to develop against the converted archive, use 'git clone'.

  To convert the view incrementally, go to the root of the git repository
  (which contains the '.git' directory), and call 'git-ucmimport' without
  any parameters. In this example case that would be from c:\\jparser_git .

  For more information regarding the options, read the top of this script.

}
$opts.on("--help", "-h", "This usage") { puts $opts; exit 1 }
$opts.on(
  "--authors-file FILE", "-A",
  "Add file with mapping from ClearCase user", "to git author"
) { |f| $ucm_authors_file = File.expand_path(f) }
$opts.on("\nOptions for first-time import:")
$opts.on(
  "--stgloc LOCATION",
  "Server Storage Location for the view",
  "storage directory [chosen by UCM]"
) { |s| stgloc = s }
$opts.on(
  "--first-baseline BASELINE",
  "Start importing at given baseline", "[oldest baseline]"
) { |bl| first_baseline = bl }
$opts.on(
  "--root DIRINREPO",
  "Make given directory the root of the git", "repository"
) { |sr| $sub_root = sr }
$opts.on("")
begin
  $opts.parse!(ARGV)
rescue OptionParser::InvalidOption
  die("!!! Invalid option", $opts)
end

if !state_loaded
  if ARGV.size != 2
    puts $opts
    die("!!! Need at least the import and export directory")
  end
  $int_view_dir, $sub_view_dir = ARGV
end

# Git: Location of git archive
$git_root = $sub_view_dir
$git_root += "/" + $sub_root if $sub_root && $sub_root != ""
$git_dir = "#{$git_root}/.git"
$state = "#{$git_dir}/git-ucmimport.state"

puts "UCM Source:      Dynamic view at \"#{$int_view_dir}\""
puts "UCM Mirror repo: Snapshot view at \"#{$sub_view_dir}\""
puts "git repo:        At \"#{$git_root}\""
puts "Start baseline:  At #{first_baseline}" if first_baseline && first_baseline != ""
puts

# Check for existance of git in $PATH
safe_system("git version")

if !File.directory?($int_view_dir)
  die(
      "!!! Cannot find \"#{$int_view_dir}\",",
      "!!! which should contain integration view directory.",
      "!!! Did you start your view?"
  )
end

puts "\n=== Retrieving all current baselines to import"
Dir.chdir($int_view_dir)
vob = nil			# String: VOB
int_stream = nil		# String: name of stream
baselines = {}			# From name to Baseline
baseline = nil
#File.open("c:\\temp\\lsbl.memberof", "rb") { |io|
File.popen("cleartool lsbl -member_of", "rb") { |io|
  while line = io.gets
    line = line.rstrip
    if line =~ %r{^([^\s]+)\s+([^\s]+)\s+([^\s]+)\s+\"(.*)\"$}
      # New baseline found
      date, name, author, comment = $1, $2, $3, $4
      $VERBOSE = false		# Time.parse warns about year...
      baseline = Baseline.new(name, Time.parse(date), author, comment)
      $VERBOSE = true
      $stderr.print "." if baselines.size % 10 == 0
      baselines[name] = baseline
    elsif line =~ %r{^  component: ([^ @]+)@([^ ]+)$}
      baseline.component = $1
      vob = $2
    elsif line =~ %r{^  stream: ([^ @]+)@([^ ]+)$}
      int_stream = $1
    elsif line =~ %r{^    ([^ @]+)@([^ ]+) \(.*\)}
      # 'member of:' line    
      baseline.set_parent(baselines[$1])
    end
  end
}
$stderr.puts
# We only need to keep the root of all composite baselines sorted on time.
baselines =
  baselines.keys.
  find_all { |n| baselines[n].parent.nil? }. # Only keep root baselines
  collect { |n| baselines[n] }.
  sort_by { |b| b.date }	# Sort them on date
puts "Found #{baselines.size} (composite) baselines."

components = baselines.collect { |b| b.component }.uniq
if components.size != 1
  die(
      "!!! Not all baselines belong to the same component!",
      "!!! Too afraid to continue.",
      "!!! Components found: #{components.inspect}"
  )
end

if !first_baseline || first_baseline == ""
  first_baseline = baselines[0].name
end
first_baseline_idx = nil
baselines.each_with_index { |b, idx|
  first_baseline_idx = idx if b.name == first_baseline
}
if !first_baseline_idx
  die("!!! Could not find first_baseline with name \"#{first_baseline}\"")
end

# Create destination stream if needed
if !File.exist?($sub_view_dir)
  puts "\n=== Reading all rules loaded in stream to import"
  Dir.chdir($int_view_dir)
  loaded_rules = read_loaded_rules
  puts "Currently loaded rules: #{loaded_rules.inspect}"

  sub_stream = File.basename($sub_view_dir)
  puts "\n=== Creating read-only stream '#{sub_stream}'"
  safe_system(
    "cleartool mkstream",
    "-in stream:#{int_stream}@#{vob}",
    "-readonly",
    "-baseline baseline:#{first_baseline}",
    "#{sub_stream}@#{vob}"
  )

  Dir.chdir(File.dirname($sub_view_dir))
  puts "\n=== Creating snapshot view at #{$sub_view_dir}"
  safe_system(
    "cleartool mkview",
    "-snapshot -ptime",
    "-tag #{sub_stream}",
    "-stream #{sub_stream}@#{vob}",
    stgloc && stgloc != "", "-stgloc #{stgloc}",
    sub_stream
  )
  $sub_view_dir = Dir.pwd + "/" + sub_stream

  puts "\n=== Load rules and update view"
  Dir.chdir($sub_view_dir)
  loaded_rules.each { |rule|
    system_filter_output("cleartool update -overwrite -add_loadrules #{rule[1..-1]}", true)
  }

  git_init_db
  read_write_ucm_authors
  git_commit(baselines[first_baseline_idx], "Initial commit")
else
  read_write_ucm_authors
  puts "\n=== Updating view to be sure snapshot view matches UCM contents"
  Dir.chdir($sub_view_dir)
  system_filter_output("cleartool update -overwrite", true)
end

git_init_db

puts "\n=== Finding current baseline"
Dir.chdir($sub_view_dir)
cmd = "cleartool lsstream -long -obsolete"
p cmd
lsstream = `#{cmd}`
if lsstream !~ %r{^\s+foundation baselines:\s+([^@]+)@}m
  puts lsstream
  die("!!! Could not retrieve current baseline")
end
current_baseline = $1
puts "Current baseline: #{current_baseline}"
if current_baseline =~ %r{INITIAL$}
  die(
      "!!! Current baseline should be newer than INITIAL",
      "!!! Please rebase #{$sub_view_dir} to a newer baseline."
  )
end

current_baseline_idx = nil
baselines.each_with_index { |b, idx|
  current_baseline_idx = idx if b.name == current_baseline
}

if !current_baseline_idx
  die(
    "!!! Did not find our current baseline in Integration Stream.",
    "!!! Make sure that stream of view #{$sub_view_dir} is really",
    "!!! a child of stream of view #{$int_view_dir}"
  )
end

baselines_to_commit = baselines[current_baseline_idx + 1 .. -1]

if baselines_to_commit.empty?
  puts "\nNothing to do, already up-to-date."
  exit 0
end

puts "Got #{baselines_to_commit.size} baselines to convert to git commits"

puts "\n=== Abort previous rebase attempt (if any)."
Dir.chdir($sub_view_dir)
system_filter_output("cleartool rebase -cancel -force", true)

baselines_to_commit.each_with_index { |baseline, idx|
  # If a lot of loose objects in Git, repack.
  # Counts numbers of 'objects' directories, 256 max.
  Dir.chdir($git_root)
  if Dir[".git/objects/??"].size >= 253
    puts "\n=== Repacking."
    # To err is non-fatal, so no safe_system is needed.
    system("git repack -d")
  end

  puts
  puts "\n=== [#{idx + 1}/#{baselines_to_commit.size}]"
  puts "=== Reading effect of rebasing of #{$sub_view_dir} to baseline #{baseline.name}"
  Dir.chdir($sub_view_dir)
  activities = []

  # In the composite baseline, we get little information about the
  # activities we bring in. Therefore, ask all contained baselines
  # about the activities it contains.
  baseline_names = baseline.
    children_recursive.collect { |cbl| cbl.name }.join(",")
  cmd = "cleartool rebase -preview -baseline #{baseline_names}"
  safe_popen(cmd, "rb") { |io|
    while line = io.gets
      line = line.rstrip
      if line =~ %r{^\tactivity:([^\t]*)\t([^\t]*)\t\"(.*)\"$}
	id, author, comment = $1, $2, $3
	activities << Activity.new(id, author, comment)
      end
    end
  }
  activities = activities.uniq

  if activities.empty?
    puts "? New baseline contains no new activities, skipping"
    next
  end

  puts "Will retrieve activities:"
  activities.each { |a|
    puts "  #{a.author} #{a.id}"
  }

  system_filter_output("cleartool rebase -qall -baseline #{baseline.name}", false)

  subject =
    activities.find_all { |a| a.is_activity }.
    collect { |a| a.comment }.join(" / ") + "\n\n"
  msg = subject +
    activities.collect { |a| "#{a.comment}\nActivity: #{a.id}\n\n" }.join("")
  git_commit(baseline, msg)

  puts "\n=== Completing ClearCase UCM rebase."
  system_filter_output("cleartool rebase -complete", true)
}

--T4sUOijqQbZv57TR--
